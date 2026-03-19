import SwiftUI

@Observable
final class LoginViewModel {
    var email: String = ""
    var password: String = ""
    var isLoading: Bool = false
    var error: String?
    var isAuthenticated: Bool = false

    func login() {
        // Basic validation
        guard !email.isEmpty, !password.isEmpty else {
            error = "Please enter email and password."
            return
        }
        error = nil
        isLoading = true
        // Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.isLoading = false
            self.isAuthenticated = true
        }
    }

    func reset() {
        email = ""
        password = ""
        error = nil
        isLoading = false
        isAuthenticated = false
    }
}

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Login")
                    .font(.largeTitle)
                    .bold()

                TextField("Email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .textFieldStyle(.roundedBorder)

                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(.roundedBorder)

                if let error = viewModel.error {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }

                if viewModel.isLoading {
                    ProgressView()
                } else {
                    Button(action: {
                        viewModel.login()
                    }) {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                }

                Spacer().frame(height: 10)

                HStack {
                    Text("New here?")
                    Button("Create account") {
                        // Navigation to sign-up flow would be implemented in the app
                    }
                }
                .font(.footnote)
            }
            .padding()
            .navigationTitle("Login")
        }
    }
}

#if DEBUG
// #Preview
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = LoginViewModel()
        LoginView(viewModel: vm)
    }
}
#endif
