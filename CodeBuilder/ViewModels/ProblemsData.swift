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

    private init() {
        loadProblems()
        selectDailyProblem()
    }

  // ProblemsData.swift
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
        // Select a daily problem based on the current date
        let calendar = Calendar.current
        let dayOfYear = calendar.ordinality(of: .day, in: .year, for: Date()) ?? 0
        if !problems.isEmpty {
            let index = dayOfYear % problems.count
            dailyProblem = problems[index]
        }
    }
}
