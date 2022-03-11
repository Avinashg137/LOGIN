//
//  LoginVC.swift
//  NUTREE
//
//  Created by MAC OS on 09/03/22.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.text = "surajb.itpath@gmail.com"
                txtPassword.text = "987654321"
        // Do any additional setup after loading the view.
    }
    func isKeyPresentInUserDefaults(key: String) -> Bool {
           return UserDefaults.standard.object(forKey: key) != nil
       }
    func pushToRootHomeViewController(){
          
              let storyboard = UIStoryboard(name: "Main", bundle: nil)
              let VC  = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
              let navigationController = UINavigationController(rootViewController:VC)
              let sceneDelegate = UIApplication.shared.connectedScenes
                 .first!.delegate as! SceneDelegate
              sceneDelegate.window!.rootViewController = navigationController
      }
    @IBAction func btnClickLogin(_ sender: Any) {
    
              
                var deviceToken = String()
                
                if isKeyPresentInUserDefaults(key: "fcmToken") {
                    deviceToken = UserDefaults.standard.object(forKey: "fcmToken") as! String
                }else{
                    deviceToken = "1234"
                }
                print(deviceToken)
                
                let dict = [
                    APIManager.ParameterKey.EMAIL : txtEmail.text!.lowercased(),
                    APIManager.ParameterKey.PASSWORD : txtPassword.text!,
                    APIManager.ParameterKey.DEVICE_ID : deviceToken
                ]
        APIRequestClient.shared.sendAPIRequest(requestType: .POST, queryString: "http://stocard.project-demo.info/api/login", parameter: dict as [String:AnyObject], isHudeShow: true, success: { (responseSuccess) in
                   
                    if let success = responseSuccess as? [String:Any] {
                        if let userinfo = success["data"] as? [String:Any]{

                            DispatchQueue.main.async {
                                let userObject :UserDetail = UserDetail.init(userDetail: userinfo)
                                userObject.setuserDetailToUserDefault()
                                self.pushToRootHomeViewController()
                            }
                        }
                    }else{
                        DispatchQueue.main.async {
    
                        }
                    }
                }) { (responseFail) in
                    print(responseFail)
                    if let failResponse = responseFail  as? [String:Any],let errorMessage = failResponse["error_data"] as? [String]{

                        DispatchQueue.main.async {
                            if errorMessage.count > 0{
        //                        SAAlertBar.show(.error, message:"\(errorMessage.first!)".localizedLowercase)
                            }
                        }
                    }else{
        //                DispatchQueue.main.async {
        ////                    SAAlertBar.show(.error, message:"\(kCommonError)".localizedLowercase)
        //                }
                    }
                }
                print(dict)
                    
                
            }
    }
    

