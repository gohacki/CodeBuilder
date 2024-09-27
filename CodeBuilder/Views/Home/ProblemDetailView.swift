//
//  ProblemDetailView.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 9/24/24.
//

import SwiftUICore
import SwiftUI

struct ProblemDetailView: View {
    let problemTitle: String
    @State private var availableBlocks = ["func greet() {", "print(\"Hello World\")", "}"]
    @State private var arrangedBlocks: [String] = []

    var body: some View {
        VStack {
            Text(problemTitle)
                .font(.title)
                .padding()

            Text("Arrange the code blocks to print 'Hello World'")
                .padding(.bottom)

            HStack {
                VStack {
                    Text("Available Blocks")
                        .font(.headline)
                    ForEach(availableBlocks, id: \.self) { block in
                        Text(block)
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(5)
                            .onDrag {
                                NSItemProvider(object: block as NSString)
                            }
                    }
                }
                .padding()

                VStack {
                    Text("Your Solution")
                        .font(.headline)
                    
                    // Use LazyVStack to dynamically manage the solution blocks
                    LazyVStack {
                        ForEach(arrangedBlocks, id: \.self) { block in
                            Text(block)
                                .padding()
                                .background(Color.green.opacity(0.1))
                                .cornerRadius(5)
                        }
                    }
                    .frame(height: 200)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .onDrop(of: [.plainText], isTargeted: nil) { providers in
                        providers.first?.loadObject(ofClass: String.self) { (string, error) in
                            if let block = string {
                                DispatchQueue.main.async {
                                    arrangedBlocks.append(block)
                                    if let index = availableBlocks.firstIndex(of: block) {
                                        availableBlocks.remove(at: index)
                                    }
                                }
                            }
                        }
                        return true
                    }
                }
                .padding()
            }

            Button(action: checkSolution) {
                Text("Check Solution")
                    .font(.headline)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }

    func checkSolution() {
        // Add the correct logic for checking solution here
        let correctSolution = ["func greet() {", "print(\"Hello World\")", "}"]
        if arrangedBlocks == correctSolution {
            print("Correct!")
        } else {
            print("Try Again!")
        }
    }
}

#Preview {
  ProblemDetailView(problemTitle: "Preview")
}
