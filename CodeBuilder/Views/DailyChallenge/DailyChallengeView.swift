//
//  DailyChallengeView.swift
//  CodeBuilder
//
//  Created by aaron perkel on 9/25/24.
//

import SwiftUI

struct DailyChallengeView: View {
    @ObservedObject var problemsData = ProblemsData.shared // shared problems data

    var body: some View {
        NavigationStack {
            if let dailyProblem = problemsData.dailyProblem {
                // show the daily problem details
                ProblemDetailView(problem: dailyProblem)
                    .navigationBarTitleDisplayMode(.large)
            } else {
                // fallback when no daily problem is available
                Text("No daily challenge available.")
                    .font(.headline)
                    .padding()
            }
        }
        .applyBackgroundGradient() // apply gradient background styling
    }
}

#Preview {
    DailyChallengeView()
}
