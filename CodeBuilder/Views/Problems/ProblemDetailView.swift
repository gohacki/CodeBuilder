import SwiftUI

struct ProblemDetailView: View {
    let problem: Problem
    @State private var availableBlocks: [String]
    @State private var arrangedBlocks: [String]
    @State private var isProblemSolved = false
    @EnvironmentObject var userStatsViewModel: UserStatsViewModel
    @State private var showArticle = false

    // Add this line
    @State private var searchText = ""

    // MARK: - Initialization
    init(problem: Problem) {
        self.problem = problem
        _availableBlocks = State(initialValue: problem.availableBlocks)
        _arrangedBlocks = State(initialValue: Array(repeating: "", count: problem.correctSolution.count))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if isProblemSolved {
                    Text("🎉 Congratulations! You've solved this problem.")
                        .font(.headline)
                        .foregroundColor(.green)
                        .padding()
                }

                ProblemHeaderView(problem: problem)
              
                AvailableBlocksSection(availableBlocks: $availableBlocks)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Your Solution")
                        .font(.headline)

                    DragGestureList(
                        arrangedBlocks: $arrangedBlocks,
                        availableBlocks: $availableBlocks,
                        problem: problem,
                        isProblemSolved: $isProblemSolved,
                        userStatsViewModel: userStatsViewModel
                    )
                }
                .padding()

                SolutionButtonsSection(
                    checkSolution: checkSolution,
                    resetSolution: resetSolution,
                    openArticle: {
                        showArticle = true
                    }
                )
            }
            .padding()
        }
        .onAppear {
            if userStatsViewModel.solvedProblemIDs.contains(problem.id.uuidString) {
                isProblemSolved = true
            }
        }
        .sheet(isPresented: $showArticle) {
            ArticleDetailView(articleTitle: problem.articleTitle)
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Result"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }


    // MARK: - Additional States
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""

    // MARK: - Helper Functions
    private func checkSolution() {
        var allCorrect = true
        for index in 0..<arrangedBlocks.count {
            if arrangedBlocks[index] != problem.correctSolution[index] {
                allCorrect = false
                break
            }
        }

        if allCorrect {
            isProblemSolved = true
            userStatsViewModel.problemSolved(problemID: problem.id)
            alertMessage = "🎉 Well done! You've solved the problem."
        } else {
            alertMessage = "❌ Some blocks are incorrect. Please try again."
        }

        showingAlert = true
    }

    private func resetSolution() {
        arrangedBlocks = Array(repeating: "", count: problem.correctSolution.count)
        availableBlocks = problem.availableBlocks
        isProblemSolved = false
    }
}


struct AvailableBlocksSection: View {
    @Binding var availableBlocks: [String]
    @State private var expandedCategories: Set<String> = ["Initialization", "Control Flow", "Functions", "Others"]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Available Blocks")
                .font(.headline)

            // Categorization Logic
            ForEach(["Initialization", "Control Flow", "Functions", "Others"], id: \.self) { category in
                VStack(alignment: .leading) {
                    CategoryHeader(category: category, isExpanded: expandedCategories.contains(category)) {
                        toggleCategory(category)
                    }

                    if expandedCategories.contains(category) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(filteredAvailableBlocks(for: category), id: \.self) { block in
                                    CodeBlockView(code: block, backgroundColor: Color.blue.opacity(0.1))
                                        .onDrag {
                                            NSItemProvider(object: block as NSString)
                                        }
                                }
                            }
                        }
                        .padding(.bottom, 10)
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding()
    }

    private func toggleCategory(_ category: String) {
        if expandedCategories.contains(category) {
            expandedCategories.remove(category)
        } else {
            expandedCategories.insert(category)
        }
    }

    private func categorizeBlock(_ block: String) -> String {
        // Basic categorization logic
        if block.contains("func") || block.contains("let") || block.contains("var") {
            return "Initialization"
        } else if block.contains("if") || block.contains("for") || block.contains("while") || block.contains("return") {
            return "Control Flow"
        } else {
            return "Functions"
        }
    }

    private func filteredAvailableBlocks(for category: String) -> [String] {
        return availableBlocks.filter { categorizeBlock($0) == category }
    }
}

struct CategoryHeader: View {
    let category: String
    let isExpanded: Bool
    let toggle: () -> Void
    
    var body: some View {
        HStack {
            Text(category)
                .font(.subheadline)
                .bold()
            Spacer()
            Button(action: toggle) {
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .foregroundColor(.blue)
            }
        }
        .padding(.vertical, 5)
    }
}

struct DragGestureList: View {
    @Binding var arrangedBlocks: [String]
    @Binding var availableBlocks: [String]
    let problem: Problem
    @Binding var isProblemSolved: Bool
    @ObservedObject var userStatsViewModel: UserStatsViewModel
    
    var body: some View {
        VStack {
            ForEach(arrangedBlocks.indices, id: \.self) { index in
                if arrangedBlocks[index].isEmpty {
                    DropZoneView()
                        .onDrop(of: [.plainText], isTargeted: nil) { providers in
                            handleDrop(providers: providers, at: index)
                        }
                        .padding(.vertical, 4)
                } else {
                    CodeBlockView(code: arrangedBlocks[index], backgroundColor: Color.blue.opacity(0.2))
                        .onDrag {
                            return NSItemProvider(object: arrangedBlocks[index] as NSString)
                        }
                        .onDrop(of: [.plainText], isTargeted: nil) { providers in
                            handleDrop(providers: providers, at: index)
                        }
                        .padding(.vertical, 4)
                }
            }
        }
    }
    
    private func handleDrop(providers: [NSItemProvider], at index: Int) -> Bool {
        guard let provider = providers.first else { return false }
        provider.loadObject(ofClass: String.self) { (object, error) in
            DispatchQueue.main.async {
                if let block = object as? String {
                    // Remove block from availableBlocks
                    if let availableIndex = availableBlocks.firstIndex(of: block) {
                        availableBlocks.remove(at: availableIndex)
                    }
                    // Replace any existing block in the drop zone back to availableBlocks
                    if !arrangedBlocks[index].isEmpty {
                        availableBlocks.append(arrangedBlocks[index])
                    }
                    // Assign the new block
                    arrangedBlocks[index] = block
                }
            }
        }
        return true
    }
}

struct DropZoneView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color.gray.opacity(0.5), lineWidth: 2)
            .frame(height: 50)
            .overlay(
                Text("Drop Here")
                    .foregroundColor(.gray)
            )
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
    }
}

struct SolutionButtonsSection: View {
    let checkSolution: () -> Void
    let resetSolution: () -> Void
    let openArticle: () -> Void
    
    var body: some View {
        HStack(spacing: 20) {
            Button(action: checkSolution) {
                Text("Check Solution")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Button(action: resetSolution) {
                Text("Reset")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal)
        
        Button(action: openArticle) {
            Text("Read Article 📖")
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding(.horizontal)
    }
}

struct DragGestureList_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureList(
            arrangedBlocks: .constant(["func example() {", ""]),
            availableBlocks: .constant(["print(\"Sample\")", "}"]),
            problem: Problem(
                id: UUID(),
                title: "Sample Problem",
                description: "Arrange the code blocks to complete the function.",
                difficulty: "Easy",
                articleTitle: "Sample Problem Article"
,
                availableBlocks: [
                    "func example() {",
                    "print(\"Sample\")",
                    "}"
                ],
                correctSolution: [
                    "func example() {",
                    "print(\"Sample\")",
                    "}"
                ]
            ),
            isProblemSolved: .constant(false),
            userStatsViewModel: UserStatsViewModel()
        )
        .previewLayout(.sizeThatFits)
    }
}

struct DropZoneView_Previews: PreviewProvider {
    static var previews: some View {
        DropZoneView()
            .previewLayout(.sizeThatFits)
    }
}
