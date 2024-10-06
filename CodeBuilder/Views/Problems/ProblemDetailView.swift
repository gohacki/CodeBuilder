//
//  ProblemDetailView.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 9/24/24.
//

import SwiftUI

struct ProblemDetailView: View {
  let problemTitle: String
  @State private var availableBlocks = ["func greet() {", "print(\"Hello World\")", "}"]
  @State private var arrangedBlocks: [String?] = Array(repeating: nil, count: 3)
  @State private var blockCorrectness: [Bool?] = Array(repeating: nil, count: 3) // Tracks the correctness of each block
    @EnvironmentObject var userStatsViewModel: UserStatsViewModel

  var body: some View {
    VStack {
      Text(problemTitle)
        .font(.title)
        .padding()

      Text("Arrange the code blocks to print 'Hello World'")
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
    let correctSolution = ["func greet() {", "print(\"Hello World\")", "}"]
    for index in 0..<arrangedBlocks.count {
      if let block = arrangedBlocks[index] {
        blockCorrectness[index] = (block == correctSolution[index])
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
    arrangedBlocks = Array(repeating: nil, count: 3)
    blockCorrectness = Array(repeating: nil, count: 3)
  }
}

#Preview {
  ProblemDetailView(problemTitle: "Sample Problem")
}
