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

#Preview {
  HomeView()
}
