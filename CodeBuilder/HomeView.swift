//
//  HomeView.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 9/24/24.
//

import SwiftUI

// Home Page
struct HomeView: View {
  var body: some View {
    
    NavigationView {
      VStack(spacing: 40) {
        // Title
        Spacer()
        Text("Welcome to CodeBuilder")
          .font(.largeTitle)
          .fontWeight(.bold)
          .multilineTextAlignment(.center)

        // Blue Button
        NavigationLink(destination: ProblemsView()) {
          Text("Problems")
            .font(.title2)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.accentColor)
            .foregroundColor(.white)
            .cornerRadius(10)
        }

        // Green Button
        NavigationLink(destination: LearningView()) {
            Text("Learning")
                .font(.title2)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
        }

        // Red Button
        NavigationLink(destination: ResumeView()) {
            Text("Resume Tips")
                .font(.title2)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        Spacer()
      }
      .padding()
    }
  }
}

struct SearchView: View {
  var body: some View {
    Text("Search View")
  }
}

struct ProfileView: View {
  var body: some View {
    Text("Profile View")
  }
}

struct ContentView: View {
  var body: some View {
    TabView {
      // Home
      HomeView()
        .tabItem {
          Image(systemName: "house.fill")
          Text("Home")
        }
      
      // Search
      SearchView()
        .tabItem {
          Image(systemName: "magnifyingglass")
          Text("Search")
        }
      
      // Profile
      ProfileView()
        .tabItem {
          Image(systemName: "person.fill")
          Text("Profile")
        }
    }
  }
}

#Preview{
    ContentView()
}
