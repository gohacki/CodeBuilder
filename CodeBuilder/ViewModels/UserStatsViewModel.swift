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

class UserStatsViewModel: ObservableObject {
    @Published var problemsSolved: Int = 0 // total problems solved
    @Published var streak: Int = 0 // current streak of consecutive days
    @Published var solvedProblemIDs: [String] = [] // list of solved problem IDs

    private var db = Firestore.firestore() // Firestore database reference

    private var userID: String? {
        return Auth.auth().currentUser?.uid // current user's ID
    }
    
    // MARK: - Problem Solved Handling
    
    /// Records a solved problem and updates Firestore.
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
                    // update solved problems and streak
                    var existingSolvedProblemIDs = data[FirestoreKeys.solvedProblemIDs] as? [String] ?? []
                    if existingSolvedProblemIDs.contains(problemID.uuidString) {
                        print("Problem already solved. No increment.")
                        return nil
                    }
                    
                    var problemsSolved = data[FirestoreKeys.problemsSolved] as? Int ?? 0
                    var streak = data[FirestoreKeys.streak] as? Int ?? 0
                    let lastSolvedDate = (data[FirestoreKeys.lastProblemSolvedDate] as? Timestamp)?.dateValue() ?? Date(timeIntervalSince1970: 0)

                    let daysDifference = Calendar.current.dateComponents([.day], from: lastSolvedDate, to: currentDate).day ?? 0
                    if daysDifference == 1 {
                        streak += 1
                    } else if daysDifference > 1 {
                        streak = 1
                    }

                    problemsSolved += 1
                    existingSolvedProblemIDs.append(problemID.uuidString)

                    // Update Firestore
                    transaction.updateData([
                        FirestoreKeys.problemsSolved: problemsSolved,
                        FirestoreKeys.streak: streak,
                        FirestoreKeys.lastProblemSolvedDate: Timestamp(date: currentDate),
                        FirestoreKeys.solvedProblemIDs: existingSolvedProblemIDs
                    ], forDocument: userRef)
                } else {
                    // create a new document if it doesn't exist
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
            } else {
                print("Transaction completed successfully")
                self?.fetchUserStats() // refresh stats
            }
        }
    }
    
    // MARK: - Fetching User Statistics
    
    /// Fetches user stats from Firestore.
    func fetchUserStats() {
        guard let userID = userID else { return }
        let userRef = db.collection("users").document(userID)
        
        userRef.getDocument { [weak self] (document, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching user stats: \(error.localizedDescription)")
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
        fetchUserStats() // load stats on initialization
    }
}
