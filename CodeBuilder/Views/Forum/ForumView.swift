import SwiftUI

struct Post: Identifiable {
    var id = UUID()
    var title: String
    var replies: [String]
}

struct ForumView: View {
    @State private var path = NavigationPath()
    @State private var post = ""
    @State private var posts: [Post] = []  // Array to store posts

    @State private var reply = ""  // Text input for replies
    @State private var selectedPostId: UUID?  // Track which post the user is replying to

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Text("Post Questions for Other Community Members")
                    .font(.title2)
                    .padding(.top, 5)
                    .navigationTitle("Forum")
                    .navigationBarTitleDisplayMode(.large)

                Spacer()
                
                // Displaying all posts in the array
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(posts) { post in
                        VStack(alignment: .leading, spacing: 10) {
                            // Display the post title
                            Text("Post: \(post.title)")
                                .font(.headline)
                                .padding(.vertical, 5)
                                .background(Color(.systemGray6))
                                .cornerRadius(5)
                            
                            // Display the replies to the post
                            ForEach(post.replies, id: \.self) { reply in
                                Text("  Reply: \(reply)")
                                    .padding(.leading, 20)
                                    .padding(.vertical, 5)
                                    .background(Color(.systemGray5))
                                    .cornerRadius(5)
                            }

                            // Button to allow a reply to the post
                            Button(action: {
                                self.selectedPostId = post.id
                            }) {
                                Text("Reply")
                                    .frame(maxWidth: .infinity)
                                    .padding(8)
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(5)
                                    .font(.subheadline)
                            }
                            .padding(.top, 5)
                            
                            // Only show reply input for the selected post
                            if selectedPostId == post.id {
                                VStack {
                                    TextField("Type your reply here", text: $reply)
                                        .padding()
                                        .background(Color(.systemGray6))
                                        .cornerRadius(10)
                                        .padding(.horizontal)
                                    
                                    Button(action: {
                                        // Add the reply to the selected post
                                        if !reply.isEmpty {
                                            if let index = posts.firstIndex(where: { $0.id == post.id }) {
                                                posts[index].replies.append(reply)
                                                reply = "" // Clear the reply field
                                                selectedPostId = nil // Dismiss the reply input
                                            }
                                        }
                                    }) {
                                        Text("Submit")
                                            .frame(maxWidth: .infinity)
                                            .padding(8)
                                            .background(Color.red)
                                            .foregroundColor(.white)
                                            .cornerRadius(5)
                                            .font(.subheadline)
                                    }
                                    .padding(.top, 5)
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
                .padding(.top)
                
                Spacer()
                
                // Input field to create a new post
                TextField("Ask a Question", text: $post)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button(action: {
                    // Add the current post to the posts array and clear the input field
                    if !post.isEmpty {
                        let newPost = Post(title: post, replies: [])
                        posts.append(newPost)
                        post = "" // Clear the TextField after posting
                    }
                }) {
                    Text("Create Post")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .padding()
        }
    }
}

#Preview {
    ForumView()
}
