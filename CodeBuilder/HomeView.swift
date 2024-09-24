//
//  HomeView.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 9/24/24.
//
import SwiftUI

struct HomeView: View {
  var body: some View {
      
    NavigationView {
      // Title
      VStack() {
        Text("Home")
          .font(.largeTitle)
          .fontWeight(.bold)
          .multilineTextAlignment(.center)
        
        // Title
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
    
    // Nav Bar at Bottom
    VStack {
      TabView {
        // Home
        VStack {}
        .background(.blue)
        .tabItem {
          Image(systemName: "house.fill")
          Text("Home")
        }
        
        // Search
        VStack {}
        .background(.gray)
        .tabItem {
          Image(systemName: "magnifyingglass")
          Text("Search")
        }
        
        // Profile
        VStack {}
        .tabItem {
          Image(systemName: "person.fill")
          Text("Profile")
        }
      }
    }
  }
}

#Preview{
    HomeView()
}
