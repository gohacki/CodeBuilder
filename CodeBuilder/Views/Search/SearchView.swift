//
//  SearchView.swift
//  CodeBuilder
//
//  Created by aaron perkel on 9/25/24.
//

import SwiftUI

struct SearchView: View {
  @State private var searchText = ""
  var body: some View {
    NavigationStack {
      List {
        Section {
          TextField("\(Image(systemName: "magnifyingglass")) Search", text: $searchText)
        }
        
        Section {
          Text("Search View")
          Text("This will include types of problems")
          Text("Imagine the spotify search page")
          Text("Blocky and pictures and stuff")
          Text("Top 150 Interview Questions")
        }
      }
      .navigationTitle("Search")
      .navigationBarTitleDisplayMode(.large)
    }
  }
}

#Preview {
  SearchView()
}
