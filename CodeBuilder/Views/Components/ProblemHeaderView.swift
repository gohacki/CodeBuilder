//
//  ProblemHeaderView.swift
//  CodeBuilder
//
//  Created by aaron perkel on 10/28/24.
//

import SwiftUI

struct ProblemHeaderView: View {
    let problem: Problem // problem data to display

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // problem title
            Text(problem.title)
                .font(.title)
                .padding(.bottom, 4)

            // problem description
            Text(problem.description)
                .padding(.bottom, 4)

            // problem difficulty
            Text("Difficulty: \(problem.difficulty)")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.horizontal) // horizontal padding for the layout
    }
}
