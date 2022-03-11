//
//  APIManager.swift
//  Stocard
//
//  Created by IPS MAC OS 8 on 12/05/21.
//

import Foundation
import Alamofire
      
class APIManager: NSObject {
    
    static let sharedInstance = APIManager()
    
    struct ParameterKey {
        static let NAME = "name"
        static let CONTACT = "phone"
        static let PINCODE = "pin"
        static let IMAGE = "user_img"
        
        
        static let EMAIL = "email"
        static let PASSWORD = "password"

        static let DEVICE_ID = "device_token"
        static let DEVICE_ID1 = "device_id"
        static let CATEGORYID = "category_id"
        static let STORENAME = "stname"
        static let STOREADDRESS = "stlocation"
        static let STOREADDRESS1 = "location"
        static let STORECONTACT = "stcontact"
        static let STORECONTACT1 = "contact"
        static let STOREIMAGE = "store_img"
        
        static let STOREID = "st_id"
        static let STOREID1 = "id"
        static let STOREID2 = "store_id"
        static let CARDID = "id"
        static let CARDID1 = "card_id"

        static let CARDNAME = "cardname"
        static let CARDDETAIL = "carddetail"
        static let CARDNUMBER = "cardno"
        static let REWARDPERSENT = "rewardpercen"
        static let EXPIREDATE = "expdate"
        static let CARDIMAGE = "card_img"
        

        static let OLDPASSSWORD = "old_password"
        static let NEWPASSSWORD = "new_password"
        static let CONFIRMPASSSWORD = "confirm_password"
        
        
        static let OLDPIN = "old_pin"        
        static let NEWPIN = "new_pin"
        static let OTPPIN = "pin_otp"
        static let OTPPIN1 = "otp"
        static let FILTERID = "filter_id"
        
        static let SHARECODE  = "share_code"
        
        static let SUBJECT = "subject"
        static let DESCRIPTION = "description"
       
        static let PROVIDERID = "providerId"

    }
    

    func CallAPIPost(url:String,parameter:JSONDICTIONARY?,complition: @escaping(_ error : Error?,_ json:JSONDICTIONARY?)->())  {
        
        if Reachability.instance == .none{
            SAAlertBar.show(.error, message: "Please check your internet connection.")
            return
        }
        
        if url.contains("api/message/list") == true || url.contains("api/chat/list") == true && UserDefaults.standard.bool(forKey: "hideActivity") == true {
        }
       else {
            ExternalClass.ShowProgress()
       }
        
        //
        let header : HTTPHeaders = [
            

        ]
        
        print("API :: ------------------------------------------------------------\n\(url)")
        print("PARAMETER:: ------------------------------------------------------------\n\(parameter)")
        
        AF.request(url, method: .post, parameters: parameter,headers: header).responseJSON { (jsonResponse) in
            ExternalClass.HideProgress()
            switch jsonResponse.result {
            case .success:
                if let json = jsonResponse.result as? JSONDICTIONARY {
                    print("THIS IS A SUCCESS")
//                    print(json)
                    print("\n------------------------------------------------------------\n")
                    complition(nil, json)
                }
                break
            case .failure(let responseError):
                
                if responseError != nil{
                    SAAlertBar.show(.error, message:(responseError.localizedDescription))
                    return
                }
                
                complition(responseError, nil)
                break
            }
        }
    }
    
    
}
