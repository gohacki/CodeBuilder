//
//  ProblemsView.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 9/24/24.
//

import SwiftUI
import Combine

struct ProblemsView: View {
    @EnvironmentObject var userStatsViewModel: UserStatsViewModel
    @ObservedObject var problemsData = ProblemsData.shared

    var body: some View {
        NavigationView {
            List(problemsData.problems) { problem in
                NavigationLink(destination: ProblemDetailView(problem: problem)) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(problem.title)
                                .font(.headline)
                            if userStatsViewModel.solvedProblemIDs.contains(problem.id.uuidString) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            }
                        }
                        Text("Difficulty: \(problem.difficulty)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Problems")
        }
    }
}

#Preview {
    ProblemsView()
        .environmentObject(UserStatsViewModel())
}
