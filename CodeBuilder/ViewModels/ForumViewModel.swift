//
//  ForumViewModel.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 11/17/24.
//

// ViewModels/ForumViewModel.swift

import Foundation
import FirebaseFirestore
import Combine

// MARK: - Reply Model

struct Reply: Identifiable, Codable {
    @DocumentID var id: String?
    var content: String
    var userID: String
    var displayName: String
    var timestamp: Date

    enum CodingKeys: String, CodingKey {
        case id
        case content
        case userID
        case displayName
        case timestamp
    }
}

// MARK: - Post Model

struct Post: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var userID: String
    var displayName: String
    var timestamp: Date

    // **Reintroduced 'replies' as an optional property**
    var replies: [Reply] = []

    // **Exclude 'replies' from CodingKeys to prevent decoding issues**
    enum CodingKeys: String, CodingKey {
        case title
        case userID
        case displayName
        case timestamp
    }

    // **Custom initializer to handle 'replies'**
    init(title: String, userID: String, displayName: String, timestamp: Date, replies: [Reply] = []) {
        self.title = title
        self.userID = userID
        self.displayName = displayName
        self.timestamp = timestamp
        self.replies = replies
    }

    // **Ensure 'replies' is not decoded from Firestore data**
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.userID = try container.decode(String.self, forKey: .userID)
        self.displayName = try container.decode(String.self, forKey: .displayName)
        self.timestamp = try container.decode(Date.self, forKey: .timestamp)
        self.replies = [] // Initialize as empty; will be populated separately
    }
}

class ForumViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var errorMessage: String?
    
    private var db = Firestore.firestore()
    private var cancellables = Set<AnyCancellable>()
    private var replyListeners: [String: ListenerRegistration] = [:] // To manage reply listeners

    init() {
        fetchPosts()
    }
    
    deinit {
        // Remove all reply listeners when the ViewModel is deallocated
        for listener in replyListeners.values {
            listener.remove()
        }
    }

    /// Fetches posts from Firestore and sets up listeners for their replies.
    func fetchPosts() {
      db.collection("posts")
          .order(by: "timestamp", descending: true)
          .addSnapshotListener { [weak self] (querySnapshot, error) in
              guard let self = self else { return }
              if let error = error {
                  DispatchQueue.main.async {
                      self.errorMessage = "Failed to fetch posts: \(error.localizedDescription)"
                  }
                  print("Failed to fetch posts: \(error.localizedDescription)")
                  return
              }
              
              // Decode posts
              let fetchedPosts: [Post] = querySnapshot?.documents.compactMap { doc in
                  do {
                      var post = try doc.data(as: Post.self)
                      post.id = doc.documentID // Set the id manually
                      print("Fetched post: \(post.title) with ID: \(post.id ?? "No ID")")
                      return post
                  } catch {
                      print("Error decoding post: \(error.localizedDescription)")
                      return nil
                  }
              } ?? []
              
                
                print("Total fetched posts: \(fetchedPosts.count)")
                
                // Determine added and removed posts
                let existingPostIDs = Set(self.posts.compactMap { $0.id })
                let fetchedPostIDs = Set(fetchedPosts.compactMap { $0.id })
                
                let addedPosts = fetchedPosts.filter { post in
                    if let id = post.id {
                        return !existingPostIDs.contains(id)
                    }
                    return false
                }
                
                let removedPosts = self.posts.filter { post in
                    if let id = post.id {
                        return !fetchedPostIDs.contains(id)
                    }
                    return false
                }
                
                // Remove listeners for removed posts
                for post in removedPosts {
                    if let id = post.id, let listener = self.replyListeners[id] {
                        listener.remove()
                        self.replyListeners.removeValue(forKey: id)
                        print("Removed listener for post ID: \(id)")
                    }
                }
                
                // Add new posts and set up listeners for their replies
                for post in addedPosts {
                    if let id = post.id {
                        self.posts.append(post)
                        print("Added post: \(post.title) with ID: \(id)")
                        self.listenToReplies(for: post)
                    }
                }
                
                // Update existing posts if needed (e.g., title changes)
                for index in self.posts.indices {
                    if let fetchedPost = fetchedPosts.first(where: { $0.id == self.posts[index].id }) {
                        self.posts[index].title = fetchedPost.title
                        self.posts[index].userID = fetchedPost.userID
                        self.posts[index].displayName = fetchedPost.displayName
                        self.posts[index].timestamp = fetchedPost.timestamp
                        print("Updated post: \(self.posts[index].title) with ID: \(self.posts[index].id ?? "No ID")")
                    }
                }
            }
    }
    
    /// Sets up a listener for the replies subcollection of a given post.
    private func listenToReplies(for post: Post) {
        guard let postId = post.id else { return }
        
        let listener = db.collection("posts").document(postId).collection("replies")
            .order(by: "timestamp", descending: false)
            .addSnapshotListener { [weak self] (querySnapshot, error) in
                guard let self = self else { return }
                if let error = error {
                    DispatchQueue.main.async {
                        self.errorMessage = "Failed to fetch replies: \(error.localizedDescription)"
                    }
                    print("Failed to fetch replies: \(error.localizedDescription)")
                    return
                }
                
                let fetchedReplies: [Reply] = querySnapshot?.documents.compactMap { doc in
                    try? doc.data(as: Reply.self)
                } ?? []
                
                DispatchQueue.main.async {
                    if let index = self.posts.firstIndex(where: { $0.id == postId }) {
                        self.posts[index].replies = fetchedReplies
                        print("Updated replies for post ID: \(postId)")
                    }
                }
            }
        
        // Store the listener so it can be removed later
        replyListeners[postId] = listener
    }
    
    /// Adds a new post to Firestore.
    func addPost(title: String, userID: String, displayName: String) {
        let newPost = Post(title: title, userID: userID, displayName: displayName, timestamp: Date())
        
        do {
            let _ = try db.collection("posts").addDocument(from: newPost)
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
