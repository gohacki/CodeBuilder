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
          VStack {
            Image(systemName: "doc.text.fill")
              .resizable()
              .scaledToFit()
              .frame(height: 100)
              .foregroundStyle(.blue)
            Text("Problems")
              .font(.headline)
          }
          VStack {
            Image(systemName: "book.fill")
              .resizable()
              .scaledToFit()
              .frame(height: 100)
              .foregroundStyle(.orange)
            Text("Learning")
              .font(.headline)
          }
          VStack {
            Image(systemName: "briefcase.fill")
              .resizable()
              .scaledToFit()
              .frame(height: 100)
              .foregroundStyle(.brown)
            Text("Resume Tips")
              .font(.headline)
            }
          }
        .padding(.bottom, 20)
        .tabViewStyle(PageTabViewStyle())
        .frame(height: 200)
      }
      
      Text("Hello, Aaron")
        .font(.headline)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 15)
  
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
