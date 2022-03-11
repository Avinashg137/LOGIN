//
//  UserData.swift
//  Stocard
//
//  Created by IPS MAC OS 8 on 12/05/21.
//

import Foundation

class UserData: NSObject {
    
    static let Shared = UserData()

    var vemail : String? = ""
    var vplatform : String? = ""
    var vuserID : Int? = 0
    var vdevicetoken : String? = ""
    var vpasscode : String? = ""
    var vauthtoken : String? = ""
    var vfirstname : String? = ""
    var vlastname : String? = ""


}
