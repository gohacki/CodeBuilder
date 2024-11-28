//
//  ComposePostView.swift
//  CodeBuilder
//
//  Created by aaron perkel on 11/25/24.
//

import SwiftUI

struct ComposePostView: View {
    @EnvironmentObject var forumViewModel: ForumViewModel // forum data management
    @EnvironmentObject var authViewModel: AuthViewModel // user authentication
    @Environment(\.dismiss) var dismiss // dismisses the view

    @State private var newPostTitle: String = "" // holds the new post's title
    @State private var showingAlert: Bool = false // tracks if an alert is shown
    @State private var alertMessage: String = "" // message for the alert

    var body: some View {
        NavigationStack {
            VStack {
                // input field for the post title
                TextField("Enter your question", text: $newPostTitle)
                    .padding()
                    .background(.quinary)
                    .cornerRadius(10)
                    .padding()

                Spacer()
            }
            .navigationTitle("New Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // cancel button to dismiss the view
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                // post button to create the new post
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Post") {
                        createNewPost()
                    }
                    .disabled(newPostTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }

    // validates and creates the new post
    private func createNewPost() {
        let trimmedTitle = newPostTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTitle.isEmpty else {
            alertMessage = "Post title cannot be empty."
            showingAlert = true
            return
        }

        guard let currentUser = authViewModel.user else {
            alertMessage = "User not authenticated."
            showingAlert = true
            return
        }

        // add the post to the forum
        forumViewModel.addPost(
            title: trimmedTitle,
            userID: currentUser.uid,
            displayName: currentUser.displayName ?? "Anonymous"
        )

        dismiss() // close the compose view after posting
    }
}
