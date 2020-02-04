//
//  AppDelegate.swift
//  VoA
//
//  Created by Jung seoung Yeo on 2020/01/11.
//  Copyright © 2020 Linsaeng. All rights reserved.
//

import UIKit

import KakaoOpenSDK
import Firebase
import SwiftlyUserDefault

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
            
        }
        application.registerForRemoteNotifications()
        
        Messaging.messaging().delegate = self
        
        VoAIntegrator.shared.didFinishLaunch(launchOptions: launchOptions)
        
        guard #available(iOS 13, *) else {
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.backgroundColor = VoAColor.Style.background
            window?.rootViewController = ViewController()
            window?.makeKeyAndVisible()
            return true
        }
        
        window?.overrideUserInterfaceStyle = .light
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        KOSession.handleDidBecomeActive()
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        // 카카오 로그인
        if KOSession.isKakaoAccountLoginCallback(url.absoluteURL) {
          return KOSession.handleOpen(url)
        }
        return true
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

extension AppDelegate {
    // Called when APNs has assigned the device a unique token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Convert token to string (디바이스 토큰 값을 가져옵니다.)
//        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        Messaging.messaging().apnsToken = deviceToken
        // Print it to console(토큰 값을 콘솔창에 보여줍니다. 이 토큰값으로 푸시를 전송할 대상을 정합니다.)
//        print("APNs device token: \(deviceTokenString)")
        InstanceID.instanceID().instanceID { (result, error) in
          if let error = error {
//            print("Error fetching remote instance ID: \(error)")
          } else if let result = result {
//            print("Remote instance ID token: \(result.token)")
            SwiftlyUserDefault.fcmToken = result.token
            
          }
        }
        // Persist it in your backend in case it's new
    }
    
    // Called when APNs failed to register the device for push notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Print the error to console (you should alert the user that registration failed)
        print("APNs registration failed: \(error)")
    }

    // Push notification received
    func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
        // Print notification payload data (푸시 데이터로 받은 것을 보여줍니다.)
        print("Push notification received: \(data)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
      // If you are receiving a notification message while your app is in the background,
      // this callback will not be fired till the user taps on the notification launching the application.
      // TODO: Handle data of notification

      // With swizzling disabled you must let Messaging know about the message, for Analytics
      // Messaging.messaging().appDidReceiveMessage(userInfo)

      // Print message ID.
      if let messageID = userInfo["gcmMessageIDKey"] {
        print("Message ID: \(messageID)")
        
//        ▿ 7 elements
//        ▿ 0 : 2 elements
//          ▿ key : AnyHashable("gcm.message_id")
//            - value : "gcm.message_id"
//          - value : 1580726714541000
//        ▿ 1 : 2 elements
//          ▿ key : AnyHashable("google.c.a.udt")
//            - value : "google.c.a.udt"
//          - value : 0
//        ▿ 2 : 2 elements
//          ▿ key : AnyHashable("google.c.a.ts")
//            - value : "google.c.a.ts"
//          - value : 1580726714
//        ▿ 3 : 2 elements
//          ▿ key : AnyHashable("gcm.n.e")
//            - value : "gcm.n.e"
//          - value : 1
//        ▿ 4 : 2 elements
//          ▿ key : AnyHashable("aps")
//            - value : "aps"
//          ▿ value : 1 element
//            ▿ 0 : 2 elements
//              - key : alert
//              ▿ value : 2 elements
//                ▿ 0 : 2 elements
//                  - key : title
//                  - value : 재림아 언제올거야?
//                ▿ 1 : 2 elements
//                  - key : body
//                  - value : 우린 할리스 카운터 앞에 있어
//        ▿ 5 : 2 elements
//          ▿ key : AnyHashable("google.c.a.e")
//            - value : "google.c.a.e"
//          - value : 1
//        ▿ 6 : 2 elements
//          ▿ key : AnyHashable("google.c.a.c_id")
//            - value : "google.c.a.c_id"
//          - value : 2817705715315940380
      }

      // Print full message.
      print(userInfo)

      completionHandler(UIBackgroundFetchResult.newData)
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
      print("Firebase registration token: \(fcmToken)")

//      let dataDict:[String: String] = ["token": fcmToken]
//      NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
      
    }
}
