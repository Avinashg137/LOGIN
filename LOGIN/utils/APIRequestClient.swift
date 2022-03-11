//
//  APIRequestClient.swift
//  Stocard
//
//  Created by IPS MAC OS 8 on 12/05/21.
//
import Alamofire
import UIKit
import SystemConfiguration


typealias SUCCESS = (_ response:Any)->()
typealias FAIL = (_ response:Any)->()

let kCommonError = "Something went wrong!!"

class APIRequestClient: NSObject {
    
    enum RequestType {
        case POST
        case GET
        case PUT
        case DELETE
        case PATCH
        case OPTIONS
    }

    static let shared:APIRequestClient = APIRequestClient()
    
    func sendAPIRequest(requestType:RequestType,queryString:String?,parameter:[String:AnyObject]?,isHudeShow:Bool,success:@escaping SUCCESS,fail:@escaping FAIL){
        guard CommonClass.shared.isConnectedToInternet else{
            SAAlertBar.show(.error, message:"No Internet Connection".localizedLowercase)
            return
        }
        if isHudeShow{
            DispatchQueue.main.async {
                ExternalClass.ShowProgress()
            }
        }
        let urlString =  (queryString == nil ? "" : queryString!)
        print("===== \(urlString) =====")
        print("==== \(parameter)")
        var request = URLRequest(url: URL(string: urlString.removeWhiteSpaces())!)
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.timeoutInterval = 60
        request.httpMethod = String(describing: requestType)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        
        
        if UserDetail.isUserLoggedIn,let currentUser = UserDetail.getUserFromUserDefault(){
            print(currentUser.authToken)
            request.setValue("Bearer \(currentUser.authToken)", forHTTPHeaderField: "Authorization")
        }

        
       

        if let params = parameter{
            do{
                let parameterData = try JSONSerialization.data(withJSONObject:params, options:.prettyPrinted)
                request.httpBody = parameterData
            }catch{
                DispatchQueue.main.async {
                    ExternalClass.HideProgress()
                }
                SAAlertBar.show(.error, message:kCommonError.localizedLowercase)
                fail(["error":kCommonError])
            }
        }
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                ExternalClass.HideProgress()
            }
            if error != nil{
                SAAlertBar.show(.error, message:"\(error!.localizedDescription)".localizedLowercase)
                
                //fail(["error":"\(error!.localizedDescription)"])
            }
            if let _ = data,let httpStatus = response as? HTTPURLResponse{
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                        if httpStatus.statusCode == 403{
                            DispatchQueue.main.async(execute: {
                                print("error")
                               UserDetail.removeUserFromUserDefault()
                              // self.popToLogInViewController()
                               //self.navigationController?.popToRootViewController(animated: false)
                            })
                            fail(json)
                        }
                        print(json)
                        (httpStatus.statusCode == 200) ? success(json):fail(json)
                    }
                    catch{
                        //ShowToast.show(toatMessage: kCommonError)
                        //fail(["error":kCommonError])
                    }
            }else{
                SAAlertBar.show(.error, message:kCommonError.localizedLowercase)
                fail(["error":kCommonError])
            }
        }
        task.resume()
    }
    
    func sendAPIRequestImage(requestType:RequestType,queryString:String?,parameter:[String:AnyObject],imageData:Data?,isFileUpload:Bool = false,fileName:String = "file",filekey:String,isHudeShow:Bool,success:@escaping SUCCESS,fail:@escaping FAIL){
           guard CommonClass.shared.isConnectedToInternet else{
               SAAlertBar.show(.error, message:"No Internet Connection".localizedLowercase)
               return
           }
           if isHudeShow{
               DispatchQueue.main.async {
                   ExternalClass.ShowProgress()
               }
           }
            let urlString =  (queryString == nil ? "" : queryString!)
            print("===== \(urlString) =====")
            print("==== \(parameter)")
           var headers: HTTPHeaders = ["Content-type": "multipart/form-data"]
        
           if UserDetail.isUserLoggedIn,let currentUser = UserDetail.getUserFromUserDefault(){
                headers["Authorization"] = "Bearer \(currentUser.authToken)"
                print(currentUser.authToken)
            }
       
            AF.upload(multipartFormData: { (multipartFormData) in
               
            for (key, value) in parameter {
                   multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
             if let data = imageData{
               if isFileUpload{
                
                multipartFormData.append(imageData!, withName: "file", fileName: "\(fileName)", mimeType: "\(data.mimeType)")
               }else{
                multipartFormData.append(imageData!, withName: filekey, fileName: "image.png", mimeType: "png")
               }
            }
               
            }, to: urlString, usingThreshold: UInt64.init(), method:HTTPMethod(rawValue:"\(requestType)"), headers: headers).response{response in
                
                if response.error == nil{
                    do
                                    {
                                        if let jsonData = response.data
                                        {
                                            let parsedData = try JSONSerialization.jsonObject(with: jsonData) as! Dictionary<String, AnyObject>

                                            let success_ = parsedData["success"] as? Bool ?? false
                                            let status  = parsedData["status"] as? Bool ?? false
                                            
                                            let msg = parsedData["message"] as? String ?? ""
                                            let data = parsedData["data"] as? [String:AnyObject]
                                            print("parsedData", parsedData)
                                            if status || success_ == true  {
                                                success(data as Any)
                                            }else{
                                                SAAlertBar.show(.error, message: msg)
                                                fail(msg)
                                            }
                                           
                                            DispatchQueue.main.async {
                                                ExternalClass.HideProgress()
                                            }
                                            

                                        }
                                       
                                    } catch {
                                        SAAlertBar.show(.error, message: kCommonError)
                                        DispatchQueue.main.async {
                                            ExternalClass.HideProgress()
                                        }
                                    }
                }else{
                    print(response.error)
                    SAAlertBar.show(.error, message: kCommonError)
                    fail(response.error as Any)
                    DispatchQueue.main.async {
                        ExternalClass.HideProgress()
                    }
                }
            }
       }
}
class CommonClass{
     //SingleTon
     static let shared:CommonClass = {
        let common = CommonClass()
        return common
     }()
     var isConnectedToInternet:Bool{
         get{
             var zeroAddress = sockaddr_in()
             zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
             zeroAddress.sin_family = sa_family_t(AF_INET)
             
             guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
                 $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                     SCNetworkReachabilityCreateWithAddress(nil, $0)
                 }
             }) else {
                 return false
             }
             
             var flags: SCNetworkReachabilityFlags = []
             if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
                 return false
             }
             
             let isReachable = flags.contains(.reachable)
             let needsConnection = flags.contains(.connectionRequired)
             return (isReachable && !needsConnection)
         }
     }
     static let isSimulator: Bool = {
         return TARGET_OS_SIMULATOR == 1
     }()
     var noInternetAlertController:UIAlertController{
         get{
             let alertController = UIAlertController.init(title:"No Internet", message: "Please check your connection and try again.", preferredStyle: .alert)
             let alertAction = UIAlertAction.init(title: "Ok", style: .cancel, handler: nil)
             alertController.addAction(alertAction)
             return alertController
         }
     }
    
}
extension String{
    var changeDateFormat:String{
          let dateFormatter = DateFormatter()
          let tempLocale = dateFormatter.locale // save locale temporarily
          dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
          dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
          if let date = dateFormatter.date(from: self){
              let dateFormatter = DateFormatter()
              dateFormatter.dateStyle = .medium
              dateFormatter.dateFormat = "MM/dd/yyyy"
              let dateString = dateFormatter.string(from: date)
              return dateString
          }else{
              return self
          }
      }
        var bool: Bool? {
            switch self.lowercased() {
            case "true", "t", "yes", "y", "1":
                return true
            case "false", "f", "no", "n", "0":
                return false
            default:
                return nil
            }
        }
    
    func isValidEmail() -> Bool {
           let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
           return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
       }
    func converTo12hoursFormate()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        if let date = dateFormatter.date(from: self){
            dateFormatter.dateFormat = "hh:mm a"
             let date12:String = dateFormatter.string(from: date)
             return "\(date12)"
        }else{
            return self
        }
    }
    func converTo24hoursFormate()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        
        if let date = dateFormatter.date(from: self){
            dateFormatter.dateFormat = "HH:mm"
            let date24:String = dateFormatter.string(from: date)
            return "\(date24)"
        }else{
            return self
        }
    }
    func capitalizingFirstLetter() -> String {
        let first = String(prefix(1)).capitalized
        let other = String(dropFirst())
        return first.uppercased() + other.lowercased()
    }
    func removeWhiteSpaces()->String
    {
        return self.replacingOccurrences(of: " ", with: "")
    }
    var removingWhitespacesAndNewlines: String {
        return components(separatedBy: .whitespacesAndNewlines).joined()
    }
    func convertString(string: String) -> String {
        let data = string.data(using: String.Encoding.ascii, allowLossyConversion: true)
        return NSString(data: data!, encoding: String.Encoding.ascii.rawValue)! as String
    }
    func compareCaseInsensitive(str:String)->Bool{
        return self.caseInsensitiveCompare(str) == .orderedSame
    }
    
    func isContainWhiteSpace()->Bool{
        guard self.rangeOfCharacter(from: NSCharacterSet.whitespacesAndNewlines) == nil else{
            return true
        }
        return false
    }
    func isOnlyWhiteSpace()->Bool{
        let whiteSpaceSet = NSCharacterSet.whitespacesAndNewlines
        guard self.trimmingCharacters(in: whiteSpaceSet).count != 0 else{
            return true
        }
        return false
    }
   static func getSelectedLanguage()->String{
        if let selection = UserDefaults.standard.value(forKey: "selectedLanguageCode") as? String{ // 1 eng , 2 swed
            return selection.removeWhiteSpaces().lowercased()
        }
        return "1"
    }
}
extension Data {
    private static let mimeTypeSignatures: [UInt8 : String] = [
        0xFF : "image/jpeg",
        0x89 : "image/png",
        0x47 : "image/gif",
        0x49 : "image/tiff",
        0x4D : "image/tiff",
        0x25 : "application/pdf",
        0xD0 : "application/vnd",
        0x46 : "text/plain",
        ]

    var mimeType: String {
        var c: UInt8 = 0
        copyBytes(to: &c, count: 1)
        return Data.mimeTypeSignatures[c] ?? "application/octet-stream"
    }
}
