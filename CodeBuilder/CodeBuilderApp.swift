//
//  CodeBuilderApp.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 9/24/24.
//

// CodeBuilderApp.swift
import SwiftUI
import Firebase
import Combine

@main
struct CodeBuilderApp: App {
    @StateObject var authViewModel = AuthViewModel.shared
    @StateObject var userStatsViewModel = UserStatsViewModel()
    @StateObject var problemsData = ProblemsData.shared

    init() {
        configureFirebase()
    }

    private func configureFirebase() {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
            print("✅ Firebase configured successfully.")
        } else {
            print("⚠️ Firebase was already configured.")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
                .environmentObject(userStatsViewModel)
                .environmentObject(problemsData)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel.shared)
        .environmentObject(UserStatsViewModel())
<<<<<<< HEAD
        .environmentObject(ProblemsData.shared)
=======
>>>>>>> f31f8e595d8f7cc3dbe376bb2259ae8944a02eef
}
