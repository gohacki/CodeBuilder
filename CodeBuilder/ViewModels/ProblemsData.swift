// ProblemsData.swift

import Foundation

class ProblemsData: ObservableObject {
    static let shared = ProblemsData() // singleton instance
    @Published var problems: [Problem] = [] // all available problems
    @Published var dailyProblem: Problem? // the daily selected problem

    private let dailyProblemKey = "DailyProblemID" // key for daily problem ID
    private let dailyProblemDateKey = "DailyProblemDate" // key for daily problem date

    private init() {
        loadProblems() // load problems from JSON file
        selectDailyProblem() // determine the daily problem
    }

    /// Loads problems from a local JSON file.
    private func loadProblems() {
        if let url = Bundle.main.url(forResource: "problems", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url) // read file data
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys // standard key decoding
                problems = try decoder.decode([Problem].self, from: data) // decode JSON
                print("Loaded \(problems.count) problems.")
            } catch {
                print("Error loading problems: \(error)")
            }
        } else {
            print("Problems file not found.")
        }
    }

    /// Selects or retrieves the daily problem.
    private func selectDailyProblem() {
        let today = Calendar.current.startOfDay(for: Date()) // today's date
        let storedDate = UserDefaults.standard.object(forKey: dailyProblemDateKey) as? Date ?? Date(timeIntervalSince1970: 0)

        if Calendar.current.isDate(today, inSameDayAs: storedDate),
           let problemIDString = UserDefaults.standard.string(forKey: dailyProblemKey),
           let problemID = UUID(uuidString: problemIDString),
           let problem = problems.first(where: { $0.id == problemID }) {
            // Use the stored problem if it's for today
            dailyProblem = problem
            print("Using stored daily problem: \(problem.title)")
        } else {
            // Select a new random problem if no valid stored problem exists
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
