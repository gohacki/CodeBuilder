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

  var body: some View {
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
  }
}

#Preview {
  HomeView()
}
