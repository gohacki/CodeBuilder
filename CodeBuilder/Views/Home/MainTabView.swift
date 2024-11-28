//
//  MainTabView.swift
//  CodeBuilder
//
//  Created by aaron perkel on 11/27/24.
//


// Views/MainTabView.swift

import SwiftUI

struct MainTabView: View {
    var body: some View {
      TabView {
                  HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                  ProblemsView()
                    .tabItem {
                        Label("Problems", systemImage: "list.number")
                    }
                  DailyChallengeView()
                    .tabItem {
                        Label("Daily Challenge", systemImage: "star.fill")
                    }
                  ForumView()
                    .tabItem {
                      Label("Forum", systemImage: "paperplane.fill")
                  }
                  SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape.fill")
                    }
              }
        
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(AuthViewModel.shared)
            .environmentObject(UserStatsViewModel())
            .environmentObject(ProblemsData.shared)
            .environmentObject(ForumViewModel())
    }
}
