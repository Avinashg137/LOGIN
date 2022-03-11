
import Foundation

let sUserDefault = UserDefaults.standard
let sUserDetail = "UserDetail"
let sFireBaseToken = "FireBaseToken"
class UserDetail:NSObject,Codable {
    var authToken : String = ""
    var id = ""
    var name = ""
    var email = ""
    var pin = ""
    var phone = ""
    var image = ""
    
    init(userDetail : [String:Any]) {
        super.init()
        if let authtoken = userDetail["token"]{
            self.authToken = "\(authtoken)"
        }
        if let userid = userDetail["id"]{
            self.id = "\(userid)"
        }
        if let name = userDetail["name"]{
            self.name = "\(name)"
        }
        if let email = userDetail["email"]{
            self.email = "\(email)"
        }
        if let pin = userDetail["pin"]{
            self.pin = "\(pin)"
        }
        if let phone = userDetail["phone"]{
            self.phone = "\(phone)"
        }
        if let image = userDetail["Image"]{
            self.image = "\(image)"
        }
    }
    
}
extension UserDetail{
    
    func assignDefaultValueBeforeSuperInit(){
        
    }
    static var isUserLoggedIn:Bool{
        if let userDetail  = sUserDefault.value(forKey: sUserDetail) as? Data{
            return self.isValiduserDetail(data: userDetail)
        }else{
          return false
        }
    }
    func setuserDetailToUserDefault(){
        do{
            let userDetail = try JSONEncoder().encode(self)
            //update login
            //UserSetting.isUserLogin = true
            sUserDefault.setValue(userDetail, forKey:sUserDetail)
            sUserDefault.synchronize()
        }catch{
            DispatchQueue.main.async {
//                SAAlertBar.show(.error, message:"\(kCommonError)".localizedLowercase)
                //ShowToast.show(toatMessage: kCommonError)
            }
        }
    }
    static func isValiduserDetail(data:Data)->Bool{
        do {
            let _ = try JSONDecoder().decode(UserDetail.self, from: data)
            return true
        }catch{
            return false
        }
    }
    static func getUserFromUserDefault() -> UserDetail?{
        if let userDetail = sUserDefault.value(forKey: sUserDetail) as? Data{
            do {
                let user:UserDetail = try JSONDecoder().decode(UserDetail.self, from: userDetail)
                return user
            }catch{
                DispatchQueue.main.async {
//                    SAAlertBar.show(.error, message:"\(kCommonError)".localizedLowercase)
                }
                return nil
            }
        }
        DispatchQueue.main.async {
            //ShowToast.show(toatMessage: kCommonError)
        }
        return nil
    }
    
    static func updateUserPin(pin : String) -> UserDetail?{
        if let userDetail = sUserDefault.value(forKey: sUserDetail) as? Data{
            do {
                let user:UserDetail = try JSONDecoder().decode(UserDetail.self, from: userDetail)
                user.pin = pin
                user.setuserDetailToUserDefault()
                return user
            }catch{
                DispatchQueue.main.async {
//                    SAAlertBar.show(.error, message:"\(kCommonError)".localizedLowercase)
                }
                return nil
            }
        }
        DispatchQueue.main.async {
            //ShowToast.show(toatMessage: kCommonError)
        }
        return nil
    }
    
    
    static func removeUserFromUserDefault(){
        //UserSetting.isUserLogin = false
        sUserDefault.removeObject(forKey:sUserDetail)
    }
    

    
    
}
