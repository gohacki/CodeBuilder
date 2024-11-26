// Views/Forum/ForumView.swift

import SwiftUI

struct ForumView: View {
    @EnvironmentObject var forumViewModel: ForumViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.colorScheme) var colorScheme

    @State private var showingComposePost = false
    @State private var showingPostAlert: Bool = false
    @State private var postAlertMessage: String = ""

  var body: some View {
    GradientBackgroundView {
      NavigationStack {
        VStack {
          Divider()
            .padding(.vertical, 5)
          
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
        }
        .navigationTitle("Forum")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: {
              if authViewModel.isSignedIn {
                showingComposePost = true
              } else {
                showingPostAlert = true
                postAlertMessage = "Please sign in to create a post."
              }
            }) {
              Image(systemName: "square.and.pencil")
            }
          }
        }
        .sheet(isPresented: $showingComposePost) {
          ComposePostView()
            .environmentObject(forumViewModel)
            .environmentObject(authViewModel)
        }
        .alert(isPresented: $showingPostAlert) {
          Alert(
            title: Text("Error"),
            message: Text(postAlertMessage),
            dismissButton: .default(Text("OK"))
          )
        }
      }
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
