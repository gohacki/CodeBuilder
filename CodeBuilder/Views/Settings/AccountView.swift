import SwiftUI

struct AccountView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
                    .foregroundStyle(.blue)
                    .padding(.top, 25)

                VStack(spacing: 2) {
                    Text(authViewModel.user?.displayName ?? "No Name")
                        .font(.system(size: 28, weight: .semibold))
                    Text(verbatim: authViewModel.user?.email ?? "No Email")
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                }

                List {
                    Section {
                        NavigationLink(destination: Text("Personal Information")) {
                            HStack {
                                Image(systemName: "person.text.rectangle.fill")
                                    .foregroundColor(.blue)
                                Text("Personal Information")
                            }
                        }

                        NavigationLink(destination: Text("Subscription Info")) {
                            HStack {
                                Image(systemName: "plus.arrow.trianglehead.clockwise")
                                    .foregroundColor(.blue)
                                Text("Subscriptions")
                            }
                        }
                    }

                    Section {
                        Button(action: {
                            authViewModel.signOut()
                        }) {
                            Text("Sign Out")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.red)
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("CodeBuilder Account")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AccountView()
        .environmentObject(AuthViewModel())
}
