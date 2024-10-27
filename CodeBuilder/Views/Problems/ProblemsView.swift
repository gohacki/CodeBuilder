//
//  ProblemsView.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 9/24/24.
//

import SwiftUICore
import SwiftUI

struct ProblemsView: View {
    @EnvironmentObject var userStatsViewModel: UserStatsViewModel
    let problems: [Problem] = [
        Problem(
            title: "Print Hello World",
            description: "Arrange the code blocks to print 'Hello World'",
            difficulty: "Easy",
            articleURL: URL(string: "https://www.example.com/articles/hello-world")!,
            availableBlocks: ["func greet() {", "print(\"Hello World\")", "}"],
            correctSolution: ["func greet() {", "print(\"Hello World\")", "}"]
        ),
        Problem(
            title: "Calculate Sum",
            description: "Arrange the code blocks to calculate the sum of two numbers",
            difficulty: "Medium",
            articleURL: URL(string: "https://www.example.com/articles/calculate-sum")!,
            availableBlocks: ["let sum = a + b", "let a = 5", "let b = 10"],
            correctSolution: ["let a = 5", "let b = 10", "let sum = a + b"]
        ),
        // Add more problems here
    ]
    var body: some View {
        NavigationView {
            List(problems) { problem in
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
