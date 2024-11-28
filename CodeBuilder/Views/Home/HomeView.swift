import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var userStatsViewModel: UserStatsViewModel
    @Environment(\.colorScheme) var colorScheme
    @State private var showingSignIn = false
    @State private var path = NavigationPath() // handles navigation within the view
    
    var body: some View {
        NavigationStack(path: $path) { // navigation container
            ScrollView {
                VStack(spacing: 20) {
                    // profile or sign-in section
                    if authViewModel.isSignedIn {
                        ProfileHeaderView()
                    } else {
                        SignInPromptView(showingSignIn: $showingSignIn)
                    }
                    
                    AutoScroller(path: $path) // carousel for navigation shortcuts
                    
                    // progress cards section
                    VStack(spacing: 16) {
                        Text("Your Progress")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
                        HStack(spacing: 16) {
                            ProgressCardView(
                                title: "Problems Solved",
                                value: "\(userStatsViewModel.problemsSolved)",
                                iconName: "checkmark.seal.fill",
                                iconColor: .green
                            )
                            ProgressCardView(
                                title: "Lessons Completed",
                                value: "0", // update dynamically when lessons are tracked
                                iconName: "book.fill",
                                iconColor: .orange
                            )
                            ProgressCardView(
                                title: "Resume Tips Read",
                                value: "0", // update dynamically when resume tips are tracked
                                iconName: "briefcase.fill",
                                iconColor: .purple
                            )
                        }
                        .padding(.horizontal)
                    }
                }
                .sheet(isPresented: $showingSignIn) {
                    SignInView()
                        .environmentObject(authViewModel)
                }
            }
            .navigationDestination(for: TabDestination.self) { destination in
                switch destination {
                case .problems:
                    ProblemsView()
                case .learning:
                    LearningView()
                case .resumeTips:
                    ResumeView()
                }
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            )
        }
    }
}

// profile header for signed-in users
struct ProfileHeaderView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundStyle(.blue)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Welcome, \(authViewModel.user?.displayName ?? "No Name")!")
                    .font(.title2.bold())
                    .foregroundColor(.primary)
                Text("Ready to continue learning?")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding()
        .padding(.horizontal)
    }
}

// reusable progress card
struct ProgressCardView: View {
    var title: String
    var value: String
    var iconName: String
    var iconColor: Color
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 30)
                .foregroundColor(.white)
                .padding()
                .background(iconColor)
                .clipShape(Circle())

            Text(value)
                .font(.title2.bold())
                .foregroundColor(.primary)

            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.cardBackground)
                .shadow(
                    color: Color.black.opacity(colorScheme == .dark ? 0.3 : 0.1),
                    radius: 8, x: 0, y: 4
                )
        )
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel.shared)
        .environmentObject(UserStatsViewModel())
        .environmentObject(ProblemsData.shared)
        .environmentObject(ForumViewModel())
}
