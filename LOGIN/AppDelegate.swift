//
//  AppDelegate.swift
//  CouponBag
//
//  Created by MAC OS 17 on 08/03/22.
//

import UIKit
//import Firebase
//import UserNotifications
//import PushKit
//import IQKeyboardManagerSwift
//import GoogleSignIn


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
  
//        IQKeyboardManager.shared.enable = true
//        IQKeyboardManager.shared.enableAutoToolbar = false
//        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
//        // MARK: Firebase nofication configure
//
//        FirebaseApp.configure()
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
//          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        } else {
          let settings: UIUserNotificationSettings =
          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }
       
        // Google login
      //  GIDSignIn.sharedInstance.clientID = "483897567466-jqav30compeehkjqq48bln8v69vg672k.apps.googleusercontent.com"
        
       // Messaging.messaging().delegate = self
//        Messaging.messaging().isAutoInitEnabled = true
        window = UIWindow(frame: UIScreen.main.bounds)
        
        
        return true
    }
    
////    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//
////        Messaging.messaging().token { token, error in
////          if let error = error {
//            print("Error fetching FCM registration token: \(error)")
////          } else if let token = token {
//            print("FCM registration token: \(token)")
//            UserDefaults.standard.removeObject(forKey: "fcmToken")
//            UserDefaults.standard.set(token, forKey: "fcmToken")
//
//          }
//        }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        Messaging.messaging().apnsToken = deviceToken
    }
    
    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
       
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
       
    }
//    func application(_ application: UIApplication,
//                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
////        return GIDSignIn.sharedInstance.handle(url)
//    }


//extension AppDelegate : UNUserNotificationCenterDelegate {
//
//  // Receive displayed notifications for iOS 10 devices.
//  func userNotificationCenter(_ center: UNUserNotificationCenter,
//                              willPresent notification: UNNotification,
//    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//    let userInfo = notification.request.content.userInfo
//
//    // With swizzling disabled you must let Messaging know about the message, for Analytics
////     Messaging.messaging().appDidReceiveMessage(userInfo)
//
//    // ...
//
//    // Print full message.
//    print(userInfo)
//
//    // Change this to your preferred presentation option
////    completionHandler([[.alert, .sound]])
//  }
//
//  func userNotificationCenter(_ center: UNUserNotificationCenter,
//                              didReceive response: UNNotificationResponse,
//                              withCompletionHandler completionHandler: @escaping () -> Void) {
//    let userInfo = response.notification.request.content.userInfo
//
//    // ...
//
//    // With swizzling disabled you must let Messaging know about the message, for Analytics
////     Messaging.messaging().appDidReceiveMessage(userInfo)
//
//    // Print full message.
//    print(userInfo)
//
//    completionHandler()
//  }
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
////        if let messageID = userInfo[gcmMessageIDKey] {
////           print("Message ID: \(messageID)")
////         }
//
//         // Print full message.
//         print(userInfo)
//
//         completionHandler(UIBackgroundFetchResult.newData)
//    }
//
}
