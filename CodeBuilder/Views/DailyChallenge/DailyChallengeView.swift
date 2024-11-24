//
//  DailyChallengeView.swift
//  CodeBuilder
//
//  Created by aaron perkel on 9/25/24.
//

import SwiftUI

struct DailyChallengeView: View {
    @ObservedObject var problemsData = ProblemsData.shared

    var body: some View {
        NavigationStack {
            if let dailyProblem = problemsData.dailyProblem {
                ProblemDetailView(problem: dailyProblem)
                    .navigationBarTitleDisplayMode(.large)
            } else {
                Text("No daily challenge available.")
                    .font(.headline)
                    .padding()
            }
        }
        .applyBackgroundGradient()
    }
}

#Preview {
    DailyChallengeView()
}
