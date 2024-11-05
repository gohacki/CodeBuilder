import SwiftUI

struct ForumView: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Text("Post Questions for Other Community Members")
                .navigationTitle("Forum")
                .navigationBarTitleDisplayMode(.large)
                .font(.subheadline)
                .padding(.top,5)
                //print all posts from data
                //button to create post->create post view
                Spacer()
                
                Button(action: {
                    // Action to create a new post (you can define this later)
                            print("Create Post tapped")
                        }) {
                        Text("Create Post")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding()
                //add post to data
                //add ability to reply : new data table? postid, reply
            }
            .padding()
        }
    }
}
