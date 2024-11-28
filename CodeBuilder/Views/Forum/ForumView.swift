// Views/Forum/ForumView.swift

import SwiftUI

struct ForumView: View {
    @EnvironmentObject var forumViewModel: ForumViewModel // manages forum data
    @EnvironmentObject var authViewModel: AuthViewModel // manages user authentication
    @Environment(\.colorScheme) var colorScheme

    @State private var showingComposePost = false // tracks if the compose post view is open
    @State private var showingPostAlert: Bool = false // tracks if the alert should be shown
    @State private var postAlertMessage: String = "" // message for the alert

    var body: some View {
        GradientBackgroundView { // applies a gradient background
            NavigationStack {
                VStack {
                    Divider()
                        .padding(.vertical, 5)

                    // list of posts
                    List {
                        ForEach(forumViewModel.posts) { post in
                            PostView(post: post) // renders each post
                                .environmentObject(forumViewModel)
                                .environmentObject(authViewModel)
                                .listRowInsets(EdgeInsets()) // removes extra padding around rows
                        }
                    }
                    .listStyle(PlainListStyle()) // plain styling for the list
                }
                .navigationTitle("Forum")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        // button to create a new post
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
                    ComposePostView() // view for composing a new post
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
