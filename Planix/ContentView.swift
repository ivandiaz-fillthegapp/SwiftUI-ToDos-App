import SwiftUI

struct ContentView: View {
    @State private var authManager = AuthenticationManager()
    
    var body: some View {
        Group {
            if authManager.isAuthenticated {
                MainView()
            } else {
                LoginView()
            }
        }
        .environment(authManager)
    }
}

#Preview {
    ContentView()
}