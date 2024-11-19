import SwiftUI

struct ReplyView: View {
    var post: Post
    @EnvironmentObject var forumViewModel: ForumViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var replyContent: String = ""
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Reply to: \(post.title)")
                    .font(.headline)
                    .padding()
                
                TextEditor(text: $replyContent)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .frame(height: 150)
                
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
            .padding()
            .navigationTitle("Add Reply")
            .navigationBarItems(trailing: Button("Cancel") {
                dismiss()
            })
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
    
    // Additional State Variables
    @State private var alertTitle: String = ""
    @State private var isSuccess: Bool = false
}