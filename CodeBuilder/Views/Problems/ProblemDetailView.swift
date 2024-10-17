//
//  ProblemDetailView.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 9/24/24.
//
// ProblemDetailView.swift

import SwiftUI

struct ProblemDetailView: View {
    let problem: Problem
    @State private var availableBlocks: [String]
    @State private var arrangedBlocks: [String?]
    @State private var blockCorrectness: [Bool?]
    @EnvironmentObject var userStatsViewModel: UserStatsViewModel
    @Environment(\.openURL) var openURL

    init(problem: Problem) {
        self.problem = problem
        _availableBlocks = State(initialValue: problem.availableBlocks.shuffled())
        _arrangedBlocks = State(initialValue: Array(repeating: nil, count: problem.correctSolution.count))
        _blockCorrectness = State(initialValue: Array(repeating: nil, count: problem.correctSolution.count))
    }

    var body: some View {
        VStack {
            Text(problem.title)
                .font(.title)
                .padding()

            Text(problem.description)
                .padding(.bottom)

            Text("Difficulty: \(problem.difficulty)")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom)

            HStack(alignment: .top) {
                // Available Blocks Section
                VStack(alignment: .leading) {
                    Text("Available Blocks")
                        .font(.headline)
                    ForEach(availableBlocks, id: \.self) { block in
                        Text(block)
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(5)
                            .draggable(block)
                    }
                }
                .padding()

                // Your Solution Section
                VStack(alignment: .leading) {
                    Text("Your Solution")
                        .font(.headline)

                    ForEach(0..<arrangedBlocks.count, id: \.self) { index in
                        ZStack {
                            Rectangle()
                                .fill(Color.gray.opacity(0.1))
                                .frame(height: 50)
                                .cornerRadius(5)

                            if let block = arrangedBlocks[index] {
                                Text(block)
                                    .padding()
                                    .background(blockBackgroundColor(for: index))
                                    .cornerRadius(5)
                                    .draggable(block)
                            } else {
                                Text("Drop Here")
                                    .foregroundColor(.gray)
                            }
                        }
                        .onDrop(of: [.text], isTargeted: nil) { providers in
                            handleDrop(providers: providers, at: index)
                        }
                    }
                }
                .padding()
            }

            // Buttons Section
            HStack {
                Button(action: checkSolution) {
                    Text("Check Solution")
                        .font(.headline)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                Button(action: resetSolution) {
                    Text("Reset")
                        .font(.headline)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                Button(action: {
                    // Call problemSolved when the user solves a problem
                    userStatsViewModel.problemSolved()
                }) {
                    Text("Mark Problem as Solved")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }

            Button(action: {
                openURL(problem.articleURL)
            }) {
                Text("Read Article")
                    .font(.headline)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

        }
        .padding()
    }

    // Function to handle drop operations
    func handleDrop(providers: [NSItemProvider], at index: Int) -> Bool {
        if let provider = providers.first {
            provider.loadObject(ofClass: String.self) { (object, error) in
                DispatchQueue.main.async {
                    if let item = object {
                        // If the block is already placed somewhere else, remove it first
                        if let existingIndex = arrangedBlocks.firstIndex(where: { $0 == item }) {
                            arrangedBlocks[existingIndex] = nil
                            blockCorrectness[existingIndex] = nil
                        }

                        // Return the existing block in the slot to availableBlocks
                        if let existingBlock = arrangedBlocks[index] {
                            availableBlocks.append(existingBlock)
                        }

                        // Remove the item from availableBlocks
                        if let blockIndex = availableBlocks.firstIndex(of: item) {
                            availableBlocks.remove(at: blockIndex)
                        }

                        arrangedBlocks[index] = item
                        blockCorrectness[index] = nil // Reset correctness when the solution changes
                    }
                }
            }
            return true
        }
        return false
    }

    // Function to determine block background color after checking
    func blockBackgroundColor(for index: Int) -> Color {
        if let isCorrect = blockCorrectness[index] {
            return isCorrect ? Color.green.opacity(0.1) : Color.red.opacity(0.1)
        } else {
            return Color.clear
        }
    }

    // Function to check the solution
    func checkSolution() {
        for index in 0..<arrangedBlocks.count {
            if let block = arrangedBlocks[index] {
                blockCorrectness[index] = (block == problem.correctSolution[index])
            } else {
                blockCorrectness[index] = false
            }
        }
    }

    // Function to reset the solution
    func resetSolution() {
        // Move blocks back to availableBlocks
        for block in arrangedBlocks.compactMap({ $0 }) {
            availableBlocks.append(block)
        }
        arrangedBlocks = Array(repeating: nil, count: problem.correctSolution.count)
        blockCorrectness = Array(repeating: nil, count: problem.correctSolution.count)
    }
}

#Preview {
    ProblemDetailView(problem: Problem(
        title: "Sample Problem",
        description: "Arrange the code blocks to complete the function",
        difficulty: "Easy",
        articleURL: URL(string: "https://www.example.com/articles/sample-problem")!,
        availableBlocks: ["func example() {", "print(\"Sample\")", "}"],
        correctSolution: ["func example() {", "print(\"Sample\")", "}"]
    ))
}
