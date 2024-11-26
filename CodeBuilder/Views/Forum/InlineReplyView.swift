//
//  InlineReplyView.swift
//  CodeBuilder
//
//  Created by aaron perkel on 11/24/24.
//


import SwiftUI

struct InlineReplyView: View {
    var post: Post
    var onReplySubmitted: () -> Void

    @EnvironmentObject var forumViewModel: ForumViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var replyContent: String = ""
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var alertTitle: String = ""

  var body: some View {
          VStack(spacing: 8) {
              TextField("Write a reply...", text: $replyContent)
                  .padding(8)
                  .background(Color(.systemGray6))
                  .cornerRadius(8)

              HStack {
                  Spacer()
                  Button(action: {
                      submitReply()
                  }) {
                      Text("Submit")
                          .font(.subheadline)
                          .padding(8)
                          .background(Color.blue)
                          .foregroundColor(.white)
                          .cornerRadius(8)
                  }
              }
          }
          .padding(.horizontal)
      }

    private func submitReply() {
        // Same validation and submission logic as before
        let trimmedReply = replyContent.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedReply.isEmpty else {
            alertTitle = "Error"
            alertMessage = "Reply content cannot be empty."
            showingAlert = true
            return
        }

        guard let currentUser = authViewModel.user else {
            alertTitle = "Error"
            alertMessage = "User not authenticated."
            showingAlert = true
            return
        }

        forumViewModel.addReply(
            to: post,
            content: trimmedReply,
            userID: currentUser.uid,
            displayName: currentUser.displayName ?? "Anonymous"
        )

        // Reset reply content and notify parent view
        replyContent = ""
        onReplySubmitted()
    }
}
