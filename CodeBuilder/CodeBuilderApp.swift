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
  
  func listAllFilesInBundle() {
      guard let resourcePath = Bundle.main.resourcePath else {
          print("Unable to find resource path")
          return
      }
      let fileManager = FileManager.default
      do {
          let allFiles = try fileManager.subpathsOfDirectory(atPath: resourcePath)
          print("All files in bundle:")
          for file in allFiles {
              print(file)
          }
      } catch {
          print("Error reading bundle contents: \(error)")
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
