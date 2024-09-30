//
//  ProblemsView.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 9/24/24.
//

import SwiftUICore
import SwiftUI

struct ProblemsView: View {
    let problems = ["Sample Problem 1", "Sample Problem 2"]

    var body: some View {
        List(problems, id: \.self) { problem in
            NavigationLink(destination: ProblemDetailView(problemTitle: problem)) {
                Text(problem)
                    .font(.headline)
            }
        }
        .navigationTitle("Problems")
    }
}

#Preview {
  ProblemsView()
}
