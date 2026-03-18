import SwiftUI

struct MainView: View {
    @Environment(AuthenticationManager.self) private var authManager
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome to Planix!")
                    .font(.title)
                    .padding()
                
                Text("You are logged in.")
                    .foregroundColor(.secondary)
                
                Button("Logout") {
                    authManager.logout()
                }
                .buttonStyle(.bordered)
                .padding()
            }
            .navigationTitle("Planix")
        }
    }
}

#Preview {
    MainView()
        .environment(AuthenticationManager())
}