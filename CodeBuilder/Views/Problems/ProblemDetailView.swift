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
    @State private var draggedBlock: String?

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
                                draggedBlock = block
                                return NSItemProvider(object: block as NSString)
                            }
                    }
                }
                .padding()

                VStack {
                    Text("Your Solution")
                        .font(.headline)

                    LazyVStack {
                        ForEach(0..<arrangedBlocks.count, id: \.self) { index in
                            ZStack {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.1))
                                    .frame(height: 50)
                                    .cornerRadius(5)

                                if let block = arrangedBlocks[index] {
                                    Text(block)
                                        .padding()
                                        .background(Color.green.opacity(0.1))
                                        .cornerRadius(5)
                                } else {
                                    Text("Drop Here")
                                        .foregroundColor(.gray)
                                }
                            }
                            .onDrop(of: [.plainText], isTargeted: nil) { providers in
                                if arrangedBlocks[index] == nil {
                                    providers.first?.loadItem(forTypeIdentifier: "public.plain-text", options: nil) { (item, error) in
                                        DispatchQueue.main.async {
                                            if let data = item as? Data, let block = String(data: data, encoding: .utf8) {
                                                arrangedBlocks[index] = block
                                                if let blockIndex = availableBlocks.firstIndex(of: block) {
                                                    availableBlocks.remove(at: blockIndex)
                                                }
                                            }
                                        }
                                    }
                                    return true
                                }
                                return false
                            }
                        }
                    }
                    .frame(height: 200)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
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
        let correctSolution = ["func greet() {", "print(\"Hello World\")", "}"]
        if arrangedBlocks.compactMap({ $0 }) == correctSolution {
            print("Correct!")
        } else {
            print("Try Again!")
        }
    }
}

#Preview {
    ProblemDetailView(problemTitle: "Sample Problem")
}
