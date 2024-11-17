//
//  ProblemsData.swift
//  CodeBuilder
//
//  Created by aaron perkel on 10/28/24.
//

import Foundation

class ProblemsData: ObservableObject {
    static let shared = ProblemsData()
    @Published var problems: [Problem] = []
    @Published var dailyProblem: Problem?

    private let dailyProblemKey = "DailyProblemID"
    private let dailyProblemDateKey = "DailyProblemDate"

    private init() {
        loadProblems()
        selectDailyProblem()
    }

    private func loadProblems() {
        if let url = Bundle.main.url(forResource: "problems", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                problems = try decoder.decode([Problem].self, from: data)
                print("Loaded \(problems.count) problems.")
            } catch {
                print("Error loading problems: \(error)")
            }
        } else {
            print("Problems file not found.")
        }
    }

    private func selectDailyProblem() {
        let today = Calendar.current.startOfDay(for: Date())
        let storedDate = UserDefaults.standard.object(forKey: dailyProblemDateKey) as? Date ?? Date(timeIntervalSince1970: 0)

        if Calendar.current.isDate(today, inSameDayAs: storedDate),
           let problemIDString = UserDefaults.standard.string(forKey: dailyProblemKey),
           let problemID = UUID(uuidString: problemIDString),
           let problem = problems.first(where: { $0.id == problemID }) {
            // If the problem for today is already selected, use it
            dailyProblem = problem
            print("Using stored daily problem: \(problem.title)")
        } else {
            // Select a new random problem for today
            if !problems.isEmpty {
                dailyProblem = problems.randomElement()
                if let dailyProblem = dailyProblem {
                    UserDefaults.standard.set(dailyProblem.id.uuidString, forKey: dailyProblemKey)
                    UserDefaults.standard.set(today, forKey: dailyProblemDateKey)
                    print("Selected new daily problem: \(dailyProblem.title)")
                }
            }
        }
    }
}
