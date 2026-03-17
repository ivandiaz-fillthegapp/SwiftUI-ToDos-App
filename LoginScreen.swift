import SwiftUI

struct LoginScreen: View {
    var body: some View {
        VStack {
            Text("This is a login screen created from Planix")
                .font(.title)
                .padding()
        }
        .navigationTitle("Login")
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginScreen()
        }
    }
}
