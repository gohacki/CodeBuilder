//
//  ProblemHeaderView.swift
//  CodeBuilder
//
//  Created by aaron perkel on 10/28/24.
//


import SwiftUI

struct ProblemHeaderView: View {
    let problem: Problem

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(problem.title)
                .font(.title)
                .padding(.bottom, 4)

            Text(problem.description)
                .padding(.bottom, 4)

            Text("Difficulty: \(problem.difficulty)")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
    }
}
