//
//  ExternalClass.swift
//  Stocard
//
//  Created by IPS MAC OS 8 on 12/05/21.
//



import UIKit
import SVProgressHUD
//import IQKeyboardManagerSwift
import Reachability

class ExternalClass: NSObject {
  
    class func ShowProgress() {
        SVProgressHUD.show()
        
    }
    
    class func HideProgress() {
        SVProgressHUD.dismiss()
    }
    
    func getchangeDate(date:String) -> String  {
        // var newdate = "10-12-2018"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = dateFormatter.date(from: date as String)
        dateFormatter.dateFormat = "dd MMM, yyyy"
        return  dateFormatter.string(from: date!)
    }
    
}
