//
//  InlineReplyView.swift
//  CodeBuilder
//
//  Created by aaron perkel on 11/24/24.
//

import SwiftUI

struct InlineReplyView: View {
    var post: Post // the post to which the reply is being added
    var onReplySubmitted: () -> Void // callback to notify parent view after submission

    @EnvironmentObject var forumViewModel: ForumViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var replyContent: String = "" // holds the reply text
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var alertTitle: String = ""

    var body: some View {
        VStack(spacing: 8) {
            // input field for the reply
            TextField("Write a reply...", text: $replyContent)
                .padding(8)
                .background(.quinary)
                .cornerRadius(8)

            HStack {
                Spacer()
                // submit button
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

    // validates and submits the reply
    private func submitReply() {
        let trimmedReply = replyContent.trimmingCharacters(in: .whitespacesAndNewlines)

        // check for empty input
        guard !trimmedReply.isEmpty else {
            alertTitle = "Error"
            alertMessage = "Reply content cannot be empty."
            showingAlert = true
            return
        }

        // ensure the user is authenticated
        guard let currentUser = authViewModel.user else {
            alertTitle = "Error"
            alertMessage = "User not authenticated."
            showingAlert = true
            return
        }

        // add the reply via the forum view model
        forumViewModel.addReply(
            to: post,
            content: trimmedReply,
            userID: currentUser.uid,
            displayName: currentUser.displayName ?? "Anonymous"
        )

        // clear the input and notify parent view
        replyContent = ""
        onReplySubmitted()
    }
}
