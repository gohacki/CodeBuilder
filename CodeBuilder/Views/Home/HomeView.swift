//
//  HomeView.swift
//  CodeBuilder
//
//  Created by aaron perkel on 9/25/24.
//

import SwiftUI

// Home Page
struct HomeView: View {
  @State private var currentIndex = 0
  let tabItems: [(String, Color, AnyView)] = [
    ("Problems", Color.blue, AnyView(ProblemsView())),
    ("Learning", Color.orange, AnyView(LearningView())),
    ("Resume Tips", Color.brown, AnyView(ResumeView()))
  ]
  
  var body: some View {
    NavigationStack {
      VStack {
        Text("Hello, Aaron")
          .font(.headline)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal)
        
        AutoScroller(tabItems: tabItems)
          .frame(height: 200)
      
        List {
          Text("Maybe here we can have like")
          Text("stats or some other useful info")
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.large)
      }
    }
  }
}

#Preview {
  HomeView()
}
