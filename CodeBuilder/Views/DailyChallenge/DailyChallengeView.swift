//
//  DailyChallengeView.swift
//  CodeBuilder
//
//  Created by aaron perkel on 9/25/24.
//

import SwiftUI

struct DailyChallengeView: View {
    // Define or fetch the daily challenge problem
    let dailyProblem: Problem

    init() {
        // For this example, we'll define the daily challenge problem here.
        dailyProblem = Problem(
            title: "Daily Challenge: Factorial Function",
            description: "Arrange the code blocks to correctly implement a factorial function.",
            difficulty: "Medium",
            articleURL: URL(string: "https://www.example.com/articles/factorial-function")!,
            availableBlocks: ["func factorial(n: Int) -> Int {", "return n * factorial(n - 1)", "if n <= 1 { return 1 }", "}"],
            correctSolution: ["func factorial(n: Int) -> Int {", "if n <= 1 { return 1 }", "return n * factorial(n - 1)", "}"]
        )
    }

    var body: some View {
        NavigationStack {
            ProblemDetailView(problem: dailyProblem)
                .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    DailyChallengeView()
}
