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
        Divider()
          .padding(.vertical, 5)
          .font(.title2)
          .padding(.top, 5)
          .navigationTitle("Forum")
          .navigationBarTitleDisplayMode(.large)
        
        
        // List of Posts
        List {
            ForEach(forumViewModel.posts) { post in
                PostView(post: post)
                    .environmentObject(forumViewModel)
                    .environmentObject(authViewModel)
                    .listRowInsets(EdgeInsets())
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
    .applyBackgroundGradient()
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
