//
//  APIConstants.swift
//  Stocard
//
//  Created by IPS MAC OS 8 on 12/05/21.
//

import Foundation

typealias JSONDICTIONARY = [String : Any]

//let AppName = "Entreprenetwork"
let AppName = "StoCard"

let BaseURL =  "http://stocard.project-demo.info/api/"
let URL_Login = "\(BaseURL)login"
let URL_Register = "\(BaseURL)register"
let URL_Forgot_Password = "\(BaseURL)Forgot_Password"
let URL_ChangePassword = "\(BaseURL)ChangePassword"
let URL_CreateNewPassword = "\(BaseURL)Create_New_Password"
let URL_OTPVerify = "\(BaseURL)OTP_Verify"
let URL_ChangeProfile = "\(BaseURL)ChangeProfile"
let URL_AddStore = "\(BaseURL)AddStore"

let URL_StoreDetail = "\(BaseURL)StoreList"
let URL_StoreCategory = "\(BaseURL)FetchAll"
let URL_FilteredStore = "\(BaseURL)Filter"
    // store suggest at app start
let URL_StoreSuggest = "\(BaseURL)StoreSuggest"
let URL_StoreUpdate = "\(BaseURL)StoreUpdate"

let URL_StoreDelete = "\(BaseURL)StoreDelete"
let URL_StoreList = "\(BaseURL)StoreList"
let URL_AddCard = "\(BaseURL)StoreCard"
let URL_CardDetail = "\(BaseURL)CardDetail"
let URL_CardDelete = "\(BaseURL)CardDelete"

let URL_CardRedeem = "\(BaseURL)Card_Disable"
let URL_ShareCoupon = "\(BaseURL)ShareCode"
let URL_CollectCoupon = "\(BaseURL)AddShareCard"
let URL_GeneratePinOTP = "\(BaseURL)Forgot_Pin"
let URL_VerifyPinOTP = "\(BaseURL)OTP_Verify_Pin"
let URL_CreateNewPin = "\(BaseURL)Create_New_Pin"
let URL_ChangePin = "\(BaseURL)Change_Pin"
let URL_SetLock = "\(BaseURL)HideCard"
let URL_RemoveLock = "\(BaseURL)ShowCard"
let URL_AddToFavorite = "\(BaseURL)AddFavorite"
let URL_RemoveFromFavorite = "\(BaseURL)RemoveFavorite"
let URL_ContactUs = "\(BaseURL)ContactUs"
let URL_ReedemCoupon = "\(BaseURL)Card_Disable"
let URL_Favorite = "\(BaseURL)FetchFavorite"
let URL_SocialRegisterCheck = "\(BaseURL)socialRegisterCheck"
let URl_SocialLogin = "\(BaseURL)SocialRegister"


class APIConstant: NSObject {
    
    /// This is the Structure for API
    internal struct API {
        
              
        
        // MARK: - Basic Response keys
        
        /// Structure for API Response Keys. This will use to get the data or anything based on the key from the repsonse. Do not directly use the key rather define here and use it.
        struct Response {
            
            /// Default message key from the response
            /// ````
            /// API.Response.message
            /// ````
            static let message                                  = "message"
            
            /// Default key for Data from the response
            /// ````
            /// API.Response.data
            /// ````
            static let data                                     = "data"
            
            /// Default key for Status from the response
            /// ````
            /// API.Response.success
            /// ````
            static let success                                  = "success"
            
            /// Default key for Auth Token from the response
            /// ````
            /// API.Response.authToken
            /// ````
            static let authToken                                = "authToken"
            
            /// Default key for User from the response
            /// ````
            /// API.Response.user
            /// ````
            static let user                                     = "user"
            
            /// Default key for statusCode from the response
            /// ````
            /// API.Response.statusCode
            /// ````
            static let statusCode                               = "statusCode"
            
        }
        
        
        // MARK: - Success Failure keys
        
        /// Structure for API Response Success or Failure. This will use to check that if API has responded success or failure
        struct Check {
            
            /// Default success response
            /// ````
            /// API.Check.success
            /// ````
            static let success                                   = "true"
            
            /// Default failure response
            /// ````
            /// API.Check.failure
            /// ````
            static let failure                                   = "false"
            
            /// Default deleteAccount response
            /// ````
            /// API.Check.deleteAccount
            /// ````
            static let deleteAccount                             = "405"
            
        }
        
    }
}


