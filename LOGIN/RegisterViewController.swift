//
//  RegisterViewController.swift
//  Stocard
//
//  Created by IPS MAC OS 8 on 10/05/21.
//

import UIKit
//import YPImagePicker
//import CropViewController

class RegisterViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate {

  
   
    
   
   // @IBOutlet var profileImage: UIButton!
    
    
  
    
    @IBOutlet var nameTxtField: UITextField!
    @IBOutlet var emailTxtField: UITextField!
   // @IBOutlet var contactTxtField: UITextField!
   // @IBOutlet var securePinTxtField: UITextField!
    @IBOutlet var passwordTxtField: UITextField!
    @IBOutlet var confirmPasswordTxtField: UITextField!
    
   // var imagePickerController = UIImagePickerController()
   // var imageForCrop : UIImage?
    //var ProfileImageData:Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTxtField.text = "Sunny Mishra"
        emailTxtField.text = "sunny1234@gmail.com"
      //  contactTxtField.text = "7856231415"
     //   securePinTxtField.text = "2258"
        passwordTxtField.text = "Sunny@10226"
        confirmPasswordTxtField.text = "Sunny@10226"
        // Do any additional setup after loading the view.
    }
   // @IBAction func selectProfileImageBtn(_ sender: Any) {
     //  presentCameraAndPhotosSelector()
  //  }
 /*   @IBAction func showPasswordBtn(_ sender: UIButton) {
        if sender.isSelected == true{
            sender.isSelected = false
            if sender.tag == 101{
                passwordTxtField.isSecureTextEntry = true
               
            }else{
                confirmPasswordTxtField.isSecureTextEntry = true
                
            }
        }else{
            sender.isSelected = true
            if sender.tag == 101{
                passwordTxtField.isSecureTextEntry = false
              
            }else{
                confirmPasswordTxtField.isSecureTextEntry = false
            }
        }
    }*/
    
    @available(iOS 13.0, *)
    @IBAction func signBtn(_ sender: Any) {
        guard self.Validate() else {
            return
        }
        var deviceToken : String?
        if isKeyPresentInUserDefaults(key: "fcmToken") {
            deviceToken = UserDefaults.standard.object(forKey: "fcmToken") as? String
        }else{
            deviceToken = "1234"
        }
        print(deviceToken)
        
        let dict = [
            APIManager.ParameterKey.NAME : nameTxtField.text!,
            APIManager.ParameterKey.EMAIL : emailTxtField.text!,
            //APIManager.ParameterKey.CONTACT : contactTxtField.text!,
            APIManager.ParameterKey.PASSWORD : passwordTxtField.text!,
           // APIManager.ParameterKey.PINCODE : securePinTxtField.text!,
            APIManager.ParameterKey.DEVICE_ID : deviceToken
          
        ] as [String : Any]
        
        APIRequestClient.shared.sendAPIRequestImage(requestType: .POST, queryString: URL_Register, parameter: dict as [String:AnyObject], imageData: nil , fileName: "test",filekey:APIManager.ParameterKey.IMAGE, isHudeShow: true) { (responseSuccess) in
            print(responseSuccess)
            
                if let userinfo = responseSuccess as? [String:Any]{                    
                    DispatchQueue.main.async {
                        let userObject :UserDetail = UserDetail.init(userDetail: userinfo)
                        userObject.setuserDetailToUserDefault()
                        self.pushToRootHomeViewController()
                     if self.parent == nil {
                            self.dismiss(animated: true, completion:nil)
                       }else{
                           self.pushToRootHomeViewController()
                        }
                    }
                }
        } fail: { (failResponse) in
            print(failResponse)
        }
        
    }
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
   
    /*
    @IBAction func backPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func loginScreen(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    } */
   /* func presentCameraAndPhotosSelector(){
        //PresentMedia Selector
        let actionSheetController = UIAlertController.init(title: "", message: "Profile", preferredStyle: .actionSheet)
        let cancelSelector = UIAlertAction.init(title: "Cancel", style: .cancel, handler:nil)
        cancelSelector.setValue(UIColor(named:"38B5A3"), forKey: "titleTextColor")
        
        actionSheetController.addAction(cancelSelector)
        let photosSelector = UIAlertAction.init(title: "Photos", style: .default) { (_) in
            DispatchQueue.main.async {
                self.imagePickerController = UIImagePickerController()
                self.imagePickerController.sourceType = .savedPhotosAlbum
                self.imagePickerController.delegate = self
                self.imagePickerController.allowsEditing = false
                //self.imagePickerController.mediaTypes = [kUNT as String]
                self.view.endEditing(true)
                self.presentImagePickerController()
            }
        }
        photosSelector.setValue(UIColor(named:"38B5A3"), forKey: "titleTextColor")
        actionSheetController.addAction(photosSelector)
        
        let cameraSelector = UIAlertAction.init(title: "Camera", style: .default) { (_) in
            if CommonClass.isSimulator{
                DispatchQueue.main.async {
                    let noCamera = UIAlertController.init(title:"Cameranotsupported", message: "", preferredStyle: .alert)
                    noCamera.addAction(UIAlertAction.init(title:"ok", style: .cancel, handler: nil))
                    self.present(noCamera, animated: true, completion: nil)
                }
            }else{
                DispatchQueue.main.async {
                    self.imagePickerController = UIImagePickerController()
                    self.imagePickerController.delegate = self
                    self.imagePickerController.allowsEditing = false
                    self.imagePickerController.sourceType = .camera
                    //self.imagePickerController.mediaTypes = [kUTTypeImage as String]
                    self.presentImagePickerController()
                }
            }
        }
        cameraSelector.setValue(UIColor(named:"38B5A3"), forKey: "titleTextColor")
        actionSheetController.addAction(cameraSelector)
        self.view.endEditing(true)
        self.present(actionSheetController, animated: true, completion: nil)
    }*/
  //  func presentImagePickerController(){
       //    self.view.endEditing(true)
       //    self.imagePickerController.modalPresentationStyle = .fullScreen
       //    self.present(self.imagePickerController, animated: true, completion: nil)
    //   }
/* func resize(_ image: UIImage) -> Data{
        var actualHeight = Float(image.size.height)
        var actualWidth = Float(image.size.width)
        let maxHeight: Float = 900
        let maxWidth: Float = 900
        var imgRatio: Float = actualWidth / actualHeight
        let maxRatio: Float = maxWidth / maxHeight
        let compressionQuality: Float = 0.5
        //50 percent compression
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            }
            else if imgRatio > maxRatio {
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            }
            else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        } */
       /* let rect = CGRect(x: 0.0, y: 0.0, width: CGFloat(actualWidth), height: CGFloat(actualHeight))
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        let imageData = img!.jpegData(compressionQuality: 0.3)
        UIGraphicsEndImageContext()
        return imageData!//UIImage(data: imageData!) ?? UIImage()
    }*/
    func Validate() -> Bool {
        
       /* guard let _ = ProfileImageData else {
            SAAlertBar.show(.error, message:"Please select a profile picture".localizedLowercase)
            return false
        }*/
        
        guard let name = nameTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines),name.count > 0 else {
            //SAAlertBar.show(.error, message:"Please enter username".localizedLowercase)
            return false
        }
        
        guard let mailAddress = emailTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines),mailAddress.count > 0  else {
           // SAAlertBar.show(.error, message:"Please enter your mail-address".localizedLowercase)
            return false
        }
        
      /*  guard let contact = contactTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines),contact.count > 0  else {
            SAAlertBar.show(.error, message:"Please enter your contact number ".localizedLowercase)
            return false
        }*/
        /*guard let securePin = securePinTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines),securePin.count > 0  else {
            SAAlertBar.show(.error, message:"Please enter secure pin for store".localizedLowercase)
            return false
        }*/
        guard let password = passwordTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines),password.count > 0  else {
           // SAAlertBar.show(.error, message:"Please enter your password".localizedLowercase)
            return false
        }
        
        guard let confirmPassword = confirmPasswordTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines),confirmPassword.count > 0  else {
           // SAAlertBar.show(.error, message:"Please re-enter your password".localizedLowercase)
            return false
        }
       
      /*  guard securePin.count == 4  else {
            SAAlertBar.show(.error, message:"Secure Pin must have 4 number".localizedLowercase)
            return false
        }
        guard password.count > 8 && password.count < 18  else {
            SAAlertBar.show(.error, message:"Password must have minimum 8 and maximum 18 character ".localizedLowercase)
            return false
        }
        
        guard confirmPassword.count > 8 && confirmPassword.count < 18  else {
            SAAlertBar.show(.error, message:"Conform password must have minimum 8 and maximum 18 character ".localizedLowercase)
            return false
        }
        */
        
        
        if (emailTxtField.text?.isEmpty) == false {
                  if !self.isValidEmail(testStr: emailTxtField.text!){
                    //  SAAlertBar.show(.error, message:"Please enter valid mail".localizedLowercase)
                      return false
                  }
        }
        
        /* if (contactTxtField.text?.isEmpty) == false {
                  if !self.isValidContact(testStr: contactTxtField.text!){
                      SAAlertBar.show(.error, message:"Please enter valid phone".localizedLowercase)
                      return false
                  }
        }*/
        
        if password != confirmPassword {
         //   SAAlertBar.show(.error, message:"Both Password are not matching".localizedLowercase)
            return false
        }
        
        return true
        
    }
    
    func isValidEmail(testStr:String) -> Bool {
           let emailRegEx = "[A-Z0-9a-z]+([._%+-]{1}[A-Z0-9a-z]+)*@[A-Za-z0-9]+\\.([A-Za-z])*([A-Za-z0-9]+\\.[A-Za-z]{2,4})*"
           let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
           return emailTest.evaluate(with: testStr)
       }
    
    func isValidContact (testStr:String) -> Bool {
        let phoneNumberRegex = "^[0-9]\\d{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = phoneTest.evaluate(with: testStr)
        return isValidPhone
    }
//}

/*extension RegisterViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate,CropViewControllerDelegate {
    
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        self.dismiss(animated: true, completion: nil)
        let resizedImage = self.resize(image)
        self.profileImage.setBackgroundImage(UIImage.init(data: resizedImage), for: .normal)
        ProfileImageData = resizedImage
    }*/
    
  /*  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageForCrop = image
        }
        self.dismiss(animated: false) { [unowned self] in
                                  self.openEditor(nil, pickingViewTag: picker.view.tag)
                              }
                  
         //self.dismiss(animated:true, completion: nil)
    } */
   /* func openEditor(_ sender: UIBarButtonItem?, pickingViewTag: Int) {
        guard let image = self.imageForCrop else {
            return
        }
        
        let cropViewController = CropViewController(image: image)
        cropViewController.setAspectRatioPreset(.presetSquare, animated: true)
         cropViewController.delegate = self
        self.present(cropViewController, animated: true, completion: nil)
        
    }*/
    
   // func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //dismiss(animated: true)
 //   }
    @available(iOS 13.0, *)
    func pushToRootHomeViewController(){
        
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let VC  = storyboard.instantiateViewController(withIdentifier: "RootView") as! RootViewController
            let navigationController = UINavigationController(rootViewController:VC)
            let sceneDelegate = UIApplication.shared.connectedScenes
               .first!.delegate as! SceneDelegate
            sceneDelegate.window!.rootViewController = navigationController
    }

}
