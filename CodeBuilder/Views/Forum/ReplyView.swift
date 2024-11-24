// Views/Forum/ReplyView.swift

import SwiftUI

struct ReplyView: View {
    var post: Post
    @EnvironmentObject var forumViewModel: ForumViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss

    @State private var replyContent: String = ""
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var alertTitle: String = ""
    @State private var isSuccess: Bool = false

    var body: some View {
        VStack(spacing: 16) {
            Capsule()
                .frame(width: 40, height: 5)
                .foregroundColor(Color.gray.opacity(0.5))
                .padding(.top, 8)
            
            Text("Reply to: \(post.title)")
                .font(.headline)
                .padding(.horizontal)
                .multilineTextAlignment(.center)

            TextEditor(text: $replyContent)
                .frame(height: 100)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)

            Button(action: {
                submitReply()
            }) {
                Text("Submit Reply")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding(.bottom)
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text(alertTitle),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK")) {
                    if isSuccess {
                        dismiss()
                    }
                }
            )
        }
    }
  
    /// Handles the submission of a reply.
    private func submitReply() {
        let trimmedReply = replyContent.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedReply.isEmpty else {
            alertTitle = "Error"
            alertMessage = "Reply content cannot be empty."
            isSuccess = false
            showingAlert = true
            return
        }
        
        guard let currentUser = authViewModel.user else {
            alertTitle = "Error"
            alertMessage = "User not authenticated."
            isSuccess = false
            showingAlert = true
            return
        }
        
        forumViewModel.addReply(to: post, content: trimmedReply, userID: currentUser.uid, displayName: currentUser.displayName ?? "Anonymous")
        
        // Reset reply content and show success message
        replyContent = ""
        alertTitle = "Success"
        alertMessage = "Your reply has been posted."
        isSuccess = true
        showingAlert = true
    }
}

struct ReplyView_Previews: PreviewProvider {
    static var previews: some View {
        // Mock Post for Preview
        let mockPost = Post(title: "Sample Post", userID: "user123", displayName: "John Doe", timestamp: Date())
        return ReplyView(post: mockPost)
            .environmentObject(ForumViewModel())
            .environmentObject(AuthViewModel.shared)
    }
}
