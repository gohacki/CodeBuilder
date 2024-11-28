//
//  ArticleDetailView.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 9/24/24.
//

import SwiftUI
import MarkdownUI

struct ArticleDetailView: View {
    let articleTitle: String

    var body: some View {
        ScrollView {
            // display the markdown content or a fallback message
            if let content = loadMarkdown(for: articleTitle) {
                Markdown(content)
                    .padding()
            } else {
                Text("Content not available.")
                    .padding()
            }
        }
        .navigationTitle(articleTitle) // show the article title as the screen's title
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.2)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea() // extend the gradient to cover the full screen
        )
    }

    // load markdown content from a file based on the article title
    func loadMarkdown(for title: String) -> String? {
        let fileName = title.replacingOccurrences(of: " ", with: "") + ".md" // convert title to file name

        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            print("DEBUG: File not found for \(fileName)") // log missing file for debugging
            return nil
        }
        return try? String(contentsOf: fileURL, encoding: .utf8)
    }
}

#Preview {
    ProblemsView()
        .environmentObject(UserStatsViewModel())
}
