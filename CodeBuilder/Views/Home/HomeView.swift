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
  let tabItems = [("Problems", Color.blue), ("Learning", Color.orange), ("Resume Tips", Color.brown)]
  
  var body: some View {

    NavigationStack {
      /* // THIS IS THE LAGGY PART
      TabView(selection: $currentIndex) {
        
        ForEach(tabItems.indices, id: \.self) { index in
          VStack {
            Image(systemName: tabIcon(for: tabItems[index].0))
              .resizable()
              .scaledToFit()
              .frame(height: 100)
              .foregroundStyle(tabItems[index].1)
            Text(tabItems[index].0)
              .font(.headline)
              .padding(.bottom, 20)
          }
          .tag(index)
        }
      }
      .tabViewStyle(PageTabViewStyle())
      .frame(height: 200)
       */
      
      Text("Hello, Aaron")
        .font(.headline)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
      
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
  
  func tabIcon(for tabItem: String) -> String {
    switch tabItem {
    case "Problems":
        return "doc.text.fill"
    case "Learning":
        return "book.fill"
    case "Resume Tips":
        return "briefcase.fill"
    default:
        return "questionmark"
    }
  }
}

#Preview {
  HomeView()
}
