//
//  HomeView.swift
//  CodeBuilder
//
//  Created by aaron perkel on 9/25/24.
//

import SwiftUI

struct TabItem {
  let title: String
  let color: Color
  let destination: TabDestination
}

enum TabDestination: Hashable {
  case problems
  case learning
  case resumeTips
}

// Home Page
struct HomeView: View {
  let tabItems: [TabItem] = [
    TabItem(title: "Problems", color: .blue, destination: .problems),
    TabItem(title: "Learning", color: .orange, destination: .learning),
    TabItem(title: "Resume Tips", color: .brown, destination: .resumeTips)
  ]
  
  @State private var path = NavigationPath()
  
  var body: some View {
    NavigationStack(path: $path) {
      VStack {
        AutoScroller(tabItems: tabItems)
          .frame(height: 200)
      
        List {
          Text("Maybe here we can have like")
          Text("stats or some other useful info")
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.large)
      }
      .navigationDestination(for: TabDestination.self) { destination in
        switch destination {
        case .problems:
          ProblemsView()
        case .learning:
          LearningView()
        case .resumeTips:
          ResumeView()
        }
      }
    }
  }
}

#Preview {
  HomeView()
}
