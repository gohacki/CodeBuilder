//
//  ContentView.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 9/24/24.
//

import SwiftUI

// Home Page
struct HomeView: View {
  var body: some View {
    NavigationStack {
      List {
        NavigationLink(destination: ProblemsView()) {
          HStack {
            Image(systemName: "doc.text.fill")
              .foregroundColor(.blue)
            Text("Problems")
          }
        }
        
        NavigationLink(destination: LearningView()) {
          HStack {
            Image(systemName: "book.fill")
              .foregroundColor(.blue)
            Text("Learning")
          }
        }
        
        NavigationLink(destination: ResumeView()) {
          HStack {
            Image(systemName: "briefcase.fill")
              .foregroundColor(.blue)
            Text("Resume Tips")
          }
        }
      }
      .navigationTitle("CodeBuilder")
      .navigationBarTitleDisplayMode(.large)
    }
  }
}

struct SearchView: View {
  var body: some View {
    NavigationStack {
      Text("Search View")
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.large)
    }
  }
}

struct DailyChallengeView: View {
  var body: some View {
    NavigationStack {
      ProblemDetailView(problemTitle: "Sample Problem 1")
        .navigationTitle("Daily Challenge")
        .navigationBarTitleDisplayMode(.large)
    }
  }
}

struct ProfileView: View {
  var body: some View {
    NavigationStack {
      Text("Profile View")
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.large)
    }
  }
}

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
      
      // Profile
      NavigationStack {
        ProfileView()
      }
      .tabItem {
        Image(systemName: "person.fill")
        Text("Profile")
      }
    }
    .accentColor(.blue)
  }
}

#Preview{
    ContentView()
}
