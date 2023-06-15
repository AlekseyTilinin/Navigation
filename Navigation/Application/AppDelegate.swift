//
//  AppDelegate.swift
//  Navigation
//
//  Created by Aleksey on 30.08.2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let localNotificationsService = LocalNotificationsService()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        localNotificationsService.registeForLatestUpdatesIfPossible()
        localNotificationsService.center.delegate = self
        
        FirebaseApp.configure()

        Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
                print("User isn't authorized")
            }
        }
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error")
        }
    }
}
