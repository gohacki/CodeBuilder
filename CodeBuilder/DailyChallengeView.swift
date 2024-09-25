//
//  DailyChallengeView.swift
//  CodeBuilder
//
//  Created by aaron perkel on 9/25/24.
//

import SwiftUI

struct DailyChallengeView: View {
  var body: some View {
    NavigationStack {
      ProblemDetailView(problemTitle: "Sample Problem 1")
        .navigationTitle("Daily Challenge")
        .navigationBarTitleDisplayMode(.large)
    }
  }
}

#Preview {
  DailyChallengeView()
}
