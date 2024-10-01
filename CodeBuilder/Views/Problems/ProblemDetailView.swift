//
//  ProblemDetailView.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 9/24/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct ProblemDetailView: View {
    let problemTitle: String
    @State private var availableBlocks = ["func greet() {", "print(\"Hello World\")", "}"]
    @State private var arrangedBlocks: [String?] = Array(repeating: nil, count: 3)

    var body: some View {
        VStack {
            Text(problemTitle)
                .font(.title)
                .padding()

            Text("Arrange the code blocks to print 'Hello World'")
                .padding(.bottom)

            HStack(alignment: .top) {
                VStack(alignment: .leading) {
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
                                    .background(Color.green.opacity(0.1))
                                    .cornerRadius(5)
                            } else {
                                Text("Drop Here")
                                    .foregroundColor(.gray)
                            }
                        }
                        .onDrop(of: [UTType.plainText], isTargeted: nil) { providers in
                            if arrangedBlocks[index] == nil {
                                return handleDrop(providers: providers, index: index)
                            }
                            return false
                        }
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

    func handleDrop(providers: [NSItemProvider], index: Int) -> Bool {
        if let provider = providers.first {
            provider.loadObject(ofClass: NSString.self) { (object, error) in
                DispatchQueue.main.async {
                    if let text = object as! String? {
                        arrangedBlocks[index] = text
                        if let blockIndex = availableBlocks.firstIndex(of: text) {
                            availableBlocks.remove(at: blockIndex)
                        }
                    }
                }
            }
            return true
        }
        return false
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
