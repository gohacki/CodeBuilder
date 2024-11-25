//
//  ArticleDetailView.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 9/24/24.
//

import SwiftUI

struct ArticleDetailView: View {
    let articleTitle: String

    var body: some View {
        ScrollView {
            if let content = loadMarkdown(for: articleTitle) {
                Text(content)
                    .padding()
            } else {
                Text("Content not available.")
                    .padding()
            }
        }
        .navigationTitle(articleTitle)
    }

    func loadMarkdown(for title: String) -> String? {
        // Convert the article title to the corresponding file name
        let fileName = title.replacingOccurrences(of: " ", with: "") + ".md"

        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: nil, subdirectory: "Views/Home/Articles"),
              let content = try? String(contentsOf: fileURL, encoding: .utf8) else {
            print("DEBUG: File not found for \(fileName) in Views/Home/Articles")
            return nil
        }
        print("DEBUG: File found at \(fileURL.path)")
        return content
    }



}
