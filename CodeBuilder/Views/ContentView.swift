//
//  ContentView.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 9/24/24.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
      // Home
      NavigationStack {
        HomeView()
          .navigationDestination(for: TabDestination.self) { destination in
            switch destination {
            case .problems:
              ProblemsView()
            case .learning:
              LearningView()
            case .resumeTips:
              ResumeView()
            }
          }
      }
      .tabItem {
        Image(systemName: "house.fill")
        Text("Home")
      }
      
      // Search
      NavigationStack {
        SearchView()
      }
      .tabItem {
        Image(systemName: "magnifyingglass")
        Text("Search")
      }
      
      // Daily Challenge
      NavigationStack {
        DailyChallengeView()
      }
      .tabItem {
        Image(systemName: "calendar")
        Text("Daily Challenge")
      }
      
      // Settings
      NavigationStack {
          Group {
              if authViewModel.isSignedIn {
                  // User is signed in; show main app interface
                  SettingsView()
              } else {
                  // User is not signed in; show sign-in screen
                  SignInView()
              }
          }
      }
      .tabItem {
        Image(systemName: "gear")
        Text("Settings")
      }
    }
    .accentColor(.blue)
  }
}

#Preview{
    ContentView()
}
