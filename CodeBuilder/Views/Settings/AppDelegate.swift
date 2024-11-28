//
//  AppDelegate.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 11/17/24.
//

import UIKit
import Firebase // handles Firebase setup and integration

// AppDelegate manages app lifecycle events
class AppDelegate: NSObject, UIApplicationDelegate {
    // runs when the app is launched
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
                        [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure() // sets up Firebase for the app
        print("✅ Firebase configured successfully in AppDelegate.") // log success
        return true
    }
}
