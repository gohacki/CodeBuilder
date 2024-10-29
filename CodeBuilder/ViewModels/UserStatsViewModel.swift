//
//  UserStatsViewModel.swift
//  CodeBuilder
//
//  Created by aaron perkel on 10/28/24.
//

import Foundation
import Combine

class UserStatsViewModel: ObservableObject {
    @Published var solvedProblemIDs: Set<String> = []

    func markProblemAsSolved(problemID: String) {
        solvedProblemIDs.insert(problemID)
        saveProgress()
    }

    init() {
        loadProgress()
    }

    private func saveProgress() {
        UserDefaults.standard.set(Array(solvedProblemIDs), forKey: "solvedProblemIDs")
    }

    private func loadProgress() {
        if let savedIDs = UserDefaults.standard.array(forKey: "solvedProblemIDs") as? [String] {
            solvedProblemIDs = Set(savedIDs)
        }
    }
}
