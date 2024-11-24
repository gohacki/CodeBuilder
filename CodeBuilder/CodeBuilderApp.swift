// CodeBuilderApp.swift
import SwiftUI
import Firebase

@main
struct CodeBuilderApp: App {
    // Integrate AppDelegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @StateObject var authViewModel = AuthViewModel.shared
    @StateObject var userStatsViewModel = UserStatsViewModel()
    @StateObject var problemsData = ProblemsData.shared
    @StateObject var forumViewModel = ForumViewModel()

    var body: some Scene {
      WindowGroup {
        SplashScreenView()
            .environmentObject(authViewModel)
            .environmentObject(userStatsViewModel)
            .environmentObject(problemsData)
            .environmentObject(forumViewModel)
        
        }
      }
}

#Preview {
  SplashScreenView()
        .environmentObject(AuthViewModel.shared)
        .environmentObject(UserStatsViewModel())
        .environmentObject(ProblemsData.shared)
        .environmentObject(ForumViewModel())
}