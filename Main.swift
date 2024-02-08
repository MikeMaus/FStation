//
//  FStationWorkshopsApp.swift
//  FStationWorkshops
//
//  Created by Michael Cherniavsky on 20/12/2020.
//
// https://peterfriese.dev/swiftui-new-app-lifecycle-firebase/

import SwiftUI
import Firebase

@main
struct FStationWorkshopsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//    init( ) {
//        FirebaseApp.configure()
//    }
    @AppStorage("current_status") var status = false
    
    var body: some Scene {
        WindowGroup {
            if status {HomeView().onOpenURL(perform: { url in Auth.auth().canHandle(url) })}
            else {LoginView().onOpenURL(perform: { url in
                Auth.auth().canHandle(url)
            })}
            // I don't know where is exactly onOpenURL needed... And why it is used
            // Think about to return it back into ContentView
            
                
            //MyRecipesView()
            //LoginView()
            //ContactsView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    print("SwiftUI_2_Lifecycle_PhoneNumber_AuthApp application is starting up. ApplicationDelegate didFinishLaunchingWithOptions.")
    return true
  }

  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    print("\(#function)")
    Auth.auth().setAPNSToken(deviceToken, type: .sandbox)
  }
  
  func application(_ application: UIApplication, didReceiveRemoteNotification notification: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    print("\(#function)")
    if Auth.auth().canHandleNotification(notification) {
      completionHandler(.noData)
      return
    }
  }
  
  func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
    print("\(#function)")
    if Auth.auth().canHandle(url) {
      return true
    }
    return false
  }
}

