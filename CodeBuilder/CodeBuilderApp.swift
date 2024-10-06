//
//  CodeBuilderApp.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 9/24/24.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct CodeBuilderApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var userStatsViewModel = UserStatsViewModel()
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
                .environmentObject(userStatsViewModel)
                .onOpenURL { url in
                                    GIDSignIn.sharedInstance.handle(url)
                                }
        }
    }
}

// AppDelegate is needed for some Google Sign-In methods
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        // Attempt to restore previous sign-in state
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            // Handle restored sign-in state here if needed
        }
        return true
    }
}


#Preview {
  ContentView()
    .environmentObject(AuthViewModel())
}
