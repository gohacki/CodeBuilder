//
//  ComposePostView.swift
//  CodeBuilder
//
//  Created by aaron perkel on 11/25/24.
//


import SwiftUI

struct ComposePostView: View {
    @EnvironmentObject var forumViewModel: ForumViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss

    @State private var newPostTitle: String = ""
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Enter your question", text: $newPostTitle)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding()

                Spacer()
            }
            .navigationTitle("New Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
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

        forumViewModel.addPost(
            title: trimmedTitle,
            userID: currentUser.uid,
            displayName: currentUser.displayName ?? "Anonymous"
        )

        dismiss()
    }
}