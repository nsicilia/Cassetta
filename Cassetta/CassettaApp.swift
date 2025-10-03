//
//  CassettaApp.swift
//  Cassetta
//
//  Created by Nicholas Siciliano-Salazar  on 3/7/22.
//

import Firebase
import FirebaseAppCheck
import FirebaseAuth
import FirebaseCore
import FirebaseMessaging
import SwiftUI
import UserNotifications
import WebKit

//class AppDelegate: NSObject, UIApplicationDelegate {
//    let gcmMessageIDKey = "gcm.message_id"
//
//    // MARK: didFinishLaunchingWithOptions
//
//    func application(_ application: UIApplication,
//                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
//        let providerFactory = YourAppCheckProviderFactory()
//        AppCheck.setAppCheckProviderFactory(providerFactory)
//
//        FirebaseConfiguration.shared.setLoggerLevel(.debug)
//
//        FirebaseApp.configure()
//
//        // For development purposes only
//        //  AppCheck.setAppCheckProviderFactory(AppCheckDebugProviderFactory())
//
//        // Push Notifications
//        UNUserNotificationCenter.current().delegate = self
//
//        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//        UNUserNotificationCenter.current().requestAuthorization(
//            options: authOptions,
//            completionHandler: { _, _ in }
//        )
//
//        application.registerForRemoteNotifications()
//
//        // Messaging Delegate
//        Messaging.messaging().delegate = self
//
//        return true
//    }
//
//    //    MARK: didRegisterForRemoteNotificationsWithDeviceToken
//    func application(_ application: UIApplication,
//        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        // Swizzling
//        Messaging.messaging().apnsToken = deviceToken
//        Auth.auth().setAPNSToken(deviceToken, type: .prod)
//    }
//
//    // Needed for Firebase Phone Auth
////    func application(_ application: UIApplication,
////                     didReceiveRemoteNotification userInfo: [AnyHashable: Any],
////                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
////        if Auth.auth().canHandleNotification(userInfo) {
////            completionHandler(.noData)
////            return
////        }
////        // This notification is not auth related; it should be handled separately.
////    }
//    func application(_ application: UIApplication,
//                     didReceiveRemoteNotification notification: [AnyHashable: Any],
//                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        if Auth.auth().canHandleNotification(notification) {
//            completionHandler(.noData)
//            return
//        }
//        // This notification is not auth related; it should be handled separately.
//    }
//
//    func application(_ application: UIApplication, open url: URL,
//                     options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
//        if Auth.auth().canHandle(url) {
//            return true
//        } else {
//            print("RETURNED false")
//            return false
//        }
//        // URL not auth related; it should be handled separately.
//    }
//}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
      ) -> Bool {

        // App Check first
        AppCheck.setAppCheckProviderFactory(YourAppCheckProviderFactory())

        // Configure Firebase AS EARLY AS POSSIBLE
        FirebaseApp.configure()

        // (Optional) logging
        FirebaseConfiguration.shared.setLoggerLevel(.debug)

        // Remote notifications registration
        // For alert pushes you’d request UN auth; for phone-auth silent push it’s not required.
        UIApplication.shared.registerForRemoteNotifications()

        return true
      }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        Auth.auth().setAPNSToken(deviceToken, type: .prod)
    }
    

    // APNs silent push for Phone Auth must be forwarded here:
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
      if Auth.auth().canHandleNotification(userInfo) {
        print("Firebase Auth handled silent push.")
        completionHandler(.noData)
        return
      }
      // Handle your other notifications (if any)
      completionHandler(.noData)
    }

    // reCAPTCHA / SafetyNet redirect must be forwarded here:
      func application(_ app: UIApplication,
                       open url: URL,
                       options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if Auth.auth().canHandle(url) {
          print("Firebase Auth handled URL callback.")
          return true
        }
        // Handle other URL schemes (your deep links, etc.)
        return false
      }
    }

@main
struct CassettaApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate


    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel.shared)
        }
    }
}


class YourAppCheckProviderFactory: NSObject, AppCheckProviderFactory {
    func createProvider(with app: FirebaseApp) -> AppCheckProvider? {
        return AppAttestProvider(app: app)
    }
}

class RecaptchaDebugHelper: NSObject, WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Started loading: \(webView.url?.absoluteString ?? "nil")")
    }
}
