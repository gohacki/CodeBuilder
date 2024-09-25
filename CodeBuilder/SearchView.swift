//
//  SearchView.swift
//  CodeBuilder
//
//  Created by aaron perkel on 9/25/24.
//

import SwiftUI

struct SearchView: View {
  var body: some View {
    NavigationStack {
      Text("Search View")
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.large)
    }
  }
}

#Preview {
  SearchView()
}
