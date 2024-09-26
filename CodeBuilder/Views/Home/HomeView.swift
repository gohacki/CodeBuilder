//
//  HomeView.swift
//  CodeBuilder
//
//  Created by aaron perkel on 9/25/24.
//

import SwiftUI

// Home Page
struct HomeView: View {
  var body: some View {
    NavigationStack {
      VStack {
        TabView {
          NavigationLink(destination: ProblemsView()) {
            VStack {
              Image(systemName: "doc.text.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .foregroundStyle(.blue)
              Text("Problems")
                .font(.headline)
                .foregroundStyle(Color.primary)
            }
          }
          NavigationLink(destination: LearningView()) {
            VStack {
              Image(systemName: "book.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .foregroundStyle(.orange)
              Text("Learning")
                .font(.headline)
                .foregroundStyle(Color.primary)
            }
          }
          
          NavigationLink(destination: ResumeView()) {
            VStack {
              Image(systemName: "briefcase.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .foregroundStyle(.brown)
              Text("Resume Tips")
                .font(.headline)
                .foregroundStyle(Color.primary)
            }
          }
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(height: 200)
      }
      
      Text("Hello, Aaron")
        .font(.headline)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 15)
      
      
      List {
        Text("Maybe here we can have like")
        Text("stats or some other useful info")
      }
      .navigationTitle("Home")
      .navigationBarTitleDisplayMode(.large)
    }
  }
}

#Preview {
  HomeView()
}
