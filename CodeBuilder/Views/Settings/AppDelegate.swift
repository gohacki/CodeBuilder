//
//  AppDelegate.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 11/17/24.
//

import UIKit
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
                        [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        print("✅ Firebase configured successfully in AppDelegate.")
        return true
    }
}
