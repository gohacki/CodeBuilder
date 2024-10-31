//
//  UserStatsViewModel.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 10/1/24.
//

import Foundation
import FirebaseAuth
import Combine
import Firebase
import FirebaseFirestore

// MARK: - UserStatsViewModel

class UserStatsViewModel: ObservableObject {
    // Published properties for UI binding
    @Published var problemsSolved: Int = 0
    @Published var streak: Int = 0
    @Published var solvedProblemIDs: [String] = []
    
    private var db = Firestore.firestore()
    
    // Computed property to get current user ID
    private var userID: String? {
        return Auth.auth().currentUser?.uid
    }
    
    // MARK: - Problem Solved Handling
    
    /// Records that a problem has been solved by the user.
    func problemSolved(problemID: UUID) {
        guard let userID = userID else {
            print("No user is signed in.")
            return
        }
        
        let userRef = db.collection("users").document(userID)
        let currentDate = Date()
        
        db.runTransaction { (transaction, errorPointer) -> Any? in
            do {
                let document = try transaction.getDocument(userRef)
                
                if let data = document.data() {
                    // Check if the problem is already solved
                    var existingSolvedProblemIDs = data[FirestoreKeys.solvedProblemIDs] as? [String] ?? []
                    if existingSolvedProblemIDs.contains(problemID.uuidString) {
                        print("Problem already solved. No increment.")
                        return nil // Do not proceed
                    }
                    
                    // Proceed to update
                    var problemsSolved = data[FirestoreKeys.problemsSolved] as? Int ?? 0
                    var streak = data[FirestoreKeys.streak] as? Int ?? 0
                    let lastSolvedTimestamp = data[FirestoreKeys.lastProblemSolvedDate] as? Timestamp
                    let lastSolvedDate = lastSolvedTimestamp?.dateValue() ?? Date(timeIntervalSince1970: 0)
                    
                    let calendar = Calendar.current
                    let daysDifference = calendar.dateComponents([.day], from: lastSolvedDate, to: currentDate).day ?? 0
                    
                    if daysDifference == 1 {
                        streak += 1
                    } else if daysDifference > 1 {
                        streak = 1
                    }
                    
                    problemsSolved += 1
                    existingSolvedProblemIDs.append(problemID.uuidString)
                    
                    // Update the document
                    transaction.updateData([
                        FirestoreKeys.problemsSolved: problemsSolved,
                        FirestoreKeys.streak: streak,
                        FirestoreKeys.lastProblemSolvedDate: Timestamp(date: currentDate),
                        FirestoreKeys.solvedProblemIDs: existingSolvedProblemIDs
                    ], forDocument: userRef)
                } else {
                    // Document does not exist, create it
                    transaction.setData([
                        FirestoreKeys.email: Auth.auth().currentUser?.email ?? "",
                        FirestoreKeys.problemsSolved: 1,
                        FirestoreKeys.streak: 1,
                        FirestoreKeys.lastProblemSolvedDate: Timestamp(date: currentDate),
                        FirestoreKeys.solvedProblemIDs: [problemID.uuidString]
                    ], forDocument: userRef)
                }
            } catch let error {
                print("Transaction failed: \(error.localizedDescription)")
                errorPointer?.pointee = error as NSError
                return nil
            }
            return nil
        } completion: { [weak self] (result, error) in
            if let error = error {
                print("Transaction failed: \(error.localizedDescription)")
                // Optionally, set an error message
            } else {
                print("Transaction completed successfully")
                DispatchQueue.main.async { [weak self] in
                    self?.fetchUserStats()
                }
            }
        }
    }
    
    // MARK: - Fetching User Statistics
    
    /// Fetches the latest user statistics from Firestore.
    func fetchUserStats() {
        guard let userID = userID else { return }
        let userRef = db.collection("users").document(userID)
        
        userRef.getDocument { [weak self] (document, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching user stats: \(error.localizedDescription)")
                // Optionally, set an error message
                return
            }
            
            guard let document = document, document.exists, let data = document.data() else {
                print("User stats not found")
                return
            }
            
            DispatchQueue.main.async {
                self.problemsSolved = data[FirestoreKeys.problemsSolved] as? Int ?? 0
                self.streak = data[FirestoreKeys.streak] as? Int ?? 0
                self.solvedProblemIDs = data[FirestoreKeys.solvedProblemIDs] as? [String] ?? []
            }
        }
    }
    
    // MARK: - Initialization
    
    init() {
        fetchUserStats()
    }
}
