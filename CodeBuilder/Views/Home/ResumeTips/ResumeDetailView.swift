import SwiftUI
import MarkdownUI

struct ResumeDetailView: View {
    let articleTitle: String

    var body: some View {
        ScrollView {
            // try to load markdown content for the given article title
            if let content = loadMarkdown(for: articleTitle) {
                Markdown(content)
                    .padding()
            } else {
                Text("Content not available.") // fallback if no content is found
                    .padding()
            }
        }
        .navigationTitle(articleTitle) // use the article title as the navigation bar title
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.2)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea() // extend the gradient to the safe area
        )
    }

    // load the markdown file corresponding to the given article title
    func loadMarkdown(for title: String) -> String? {
        let fileName = title.replacingOccurrences(of: " ", with: "") + ".md" // convert title to file name

        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            print("DEBUG: File not found for \(fileName)")
            return nil
        }
        print("DEBUG: File found at \(fileURL.path)")
        return try? String(contentsOf: fileURL, encoding: .utf8) // return the content as a string
    }
}

#Preview {
    ResumeView()
        .environmentObject(UserStatsViewModel())
}
