//
//  CodeBuilderApp.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 9/24/24.
//

import SwiftUI
import Firebase

@main
struct CodeBuilderApp: App {
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var userStatsViewModel = UserStatsViewModel()
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
                .environmentObject(userStatsViewModel)
        }
    }
}


#Preview {
  ContentView()
    .environmentObject(AuthViewModel())
}
