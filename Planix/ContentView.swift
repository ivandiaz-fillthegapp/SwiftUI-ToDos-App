import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            LoginView()
                .navigationTitle("Login from Planix AI")
                .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    ContentView()
}