//
//  ForumViewModel.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 11/17/24.
//

import Foundation
import FirebaseFirestore
import Combine

class ForumViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var errorMessage: String? // New property for errors
    private var db = Firestore.firestore()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchPosts()
    }
    
    /// Fetches posts from Firestore and listens for real-time updates.
    func fetchPosts() {
        db.collection("posts")
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { [weak self] (querySnapshot, error) in
                guard let self = self else { return }
                if let error = error {
                    DispatchQueue.main.async {
                        self.errorMessage = "Failed to fetch posts: \(error.localizedDescription)"
                    }
                    return
                }
                
                self.posts = querySnapshot?.documents.compactMap { try? $0.data(as: Post.self) } ?? []
            }
    }
    
    /// Adds a new post to Firestore.
    func addPost(title: String, userID: String, displayName: String) {
        let newPost = Post(title: title, replies: [], userID: userID, displayName: displayName, timestamp: Date())
        
        do {
            try db.collection("posts").addDocument(from: newPost)
            print("Post added successfully.")
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Failed to add post: \(error.localizedDescription)"
            }
            print("Error adding post: \(error.localizedDescription)")
        }
    }
    
    /// Adds a reply to an existing post.
    func addReply(to post: Post, content: String, userID: String, displayName: String) {
        guard let postId = post.id else { return }
        let newReply = Reply(content: content, userID: userID, displayName: displayName, timestamp: Date())
        
        do {
            try db.collection("posts").document(postId).collection("replies").addDocument(from: newReply)
            print("Reply added successfully.")
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Failed to add reply: \(error.localizedDescription)"
            }
            print("Error adding reply: \(error.localizedDescription)")
        }
    }
}
