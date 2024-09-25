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
        SettingsView()
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
