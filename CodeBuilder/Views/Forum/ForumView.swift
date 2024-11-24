// Views/Forum/ForumView.swift

import SwiftUI

struct ForumView: View {
  @EnvironmentObject var forumViewModel: ForumViewModel
  @EnvironmentObject var authViewModel: AuthViewModel
  @Environment(\.colorScheme) var colorScheme
  
  @State private var newPostTitle: String = ""
  @State private var showingPostAlert: Bool = false
  @State private var postAlertMessage: String = ""
  
  // Replace selectedPost with replyingToPostIDs
  @State private var replyingToPostIDs: Set<String> = []
  
  var body: some View {
    NavigationStack {
      VStack {
        Text("Post Questions for Other Community Members")
          .font(.title2)
          .padding(.top, 5)
          .navigationTitle("Forum")
          .navigationBarTitleDisplayMode(.large)
        
        Divider()
          .padding(.vertical, 5)
        
        // List of Posts
        List {
          ForEach(forumViewModel.posts) { post in
            VStack(alignment: .leading, spacing: 8) {
              HStack {
                Text(post.displayName)
                  .font(.subheadline)
                  .foregroundColor(.blue)
                Spacer()
                Text(post.timestamp, style: .date)
                  .font(.caption)
                  .foregroundColor(.gray)
              }
              
              Text(post.title)
                .font(.headline)
                .padding(.vertical, 2)
              
              HStack {
                Image(systemName: "bubble.left.and.bubble.right.fill")
                  .foregroundColor(.green)
                Text("\(post.replies.count) Replies")
                  .font(.caption)
                  .foregroundColor(.gray)
              }
              
              // Replies Section
              if !post.replies.isEmpty {
                ForEach(post.replies) { reply in
                  HStack(alignment: .top, spacing: 8) {
                    Image(systemName: "person.crop.circle.fill")
                      .resizable()
                      .frame(width: 24, height: 24)
                      .foregroundColor(.gray)
                    VStack(alignment: .leading) {
                      Text(reply.displayName)
                        .font(.caption)
                        .foregroundColor(.blue)
                      Text(reply.content)
                        .font(.body)
                    }
                  }
                  .padding(.leading, 16)
                }
              }
              
              // Reply Button
              if authViewModel.isSignedIn {
                Button(action: {
                  if let postID = post.id {
                    if replyingToPostIDs.contains(postID) {
                      replyingToPostIDs.remove(postID)
                    } else {
                      replyingToPostIDs.insert(postID)
                    }
                  }
                }) {
                  HStack {
                    Image(systemName: "arrowshape.turn.up.left")
                    Text("Reply")
                  }
                  .font(.caption)
                  .foregroundColor(.blue)
                }
                .padding(.top, 5)
              } else {
                Text("Sign in to reply.")
                  .font(.caption)
                  .foregroundColor(.gray)
                  .padding(.top, 5)
              }
              
              // Inline Reply Input
              if let postID = post.id, replyingToPostIDs.contains(postID) {
                InlineReplyView(post: post) {
                  replyingToPostIDs.remove(postID)
                }
                .environmentObject(forumViewModel)
                .environmentObject(authViewModel)
                .padding(.leading, 16)
              }
            }
            .padding(.vertical, 8)
          }
        }
        .listStyle(PlainListStyle())
        
        Divider()
          .padding(.vertical, 5)
        
        // New Post Section
        if authViewModel.isSignedIn {
          VStack(spacing: 10) {
            TextField("Ask a Question", text: $newPostTitle)
              .padding()
              .background(Color(.systemGray6))
              .cornerRadius(10)
              .padding(.horizontal)
            
            Button(action: {
              createNewPost()
            }) {
              Text("Create Post")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
          }
        } else {
          Button(action: {
            // Prompt user to sign in
            showingPostAlert = true
            postAlertMessage = "Please sign in to create a post."
          }) {
            Text("Create Post")
              .frame(maxWidth: .infinity)
              .padding()
              .background(Color.gray)
              .foregroundColor(.white)
              .cornerRadius(10)
              .padding(.horizontal)
          }
          .padding(.bottom, 10)
        }
      }
      .alert(isPresented: $showingPostAlert) {
        Alert(
          title: Text("Error"),
          message: Text(postAlertMessage),
          dismissButton: .default(Text("OK"))
        )
      }
      .padding()
    }
  }
  /// Handles the creation of a new post.
  func createNewPost() {
    let trimmedTitle = newPostTitle.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !trimmedTitle.isEmpty else {
      postAlertMessage = "Post title cannot be empty."
      showingPostAlert = true
      return
    }
    
    guard let currentUser = authViewModel.user else {
      postAlertMessage = "User not authenticated."
      showingPostAlert = true
      return
    }
    
    forumViewModel.addPost(title: trimmedTitle, userID: currentUser.uid, displayName: currentUser.displayName ?? "Anonymous")
    newPostTitle = ""
  }
  
  struct ForumView_Previews: PreviewProvider {
    static var previews: some View {
      ForumView()
        .environmentObject(AuthViewModel.shared)
        .environmentObject(ForumViewModel())
    }
  }
}

#Preview {
  ForumView()
    .environmentObject(AuthViewModel.shared)
    .environmentObject(UserStatsViewModel())
    .environmentObject(ProblemsData.shared)
    .environmentObject(ForumViewModel())
}
