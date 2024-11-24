//
//  ProblemsView.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 9/24/24.
//

import SwiftUI

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
                    HStack {
                      Text("Difficulty:")
                        .font(.caption)
                        .padding(0)
                      
                      Text(problem.difficulty)
                      .font(.caption)
                      .padding(4)
                      .background(difficultyColor(for: problem.difficulty))
                      .foregroundColor(.white)
                      .cornerRadius(5)
                  }
                    }
                }
            }
            .navigationTitle("Problems")
        }
        .applyBackgroundGradient()
    }
}

func difficultyColor(for difficulty: String) -> Color {
    switch difficulty.lowercased() {
    case "easy":
        return .green
    case "medium":
        return .orange
    case "hard":
        return .red
    default:
        return .gray
    }
}

#Preview {
    ProblemsView()
        .environmentObject(UserStatsViewModel())
}
