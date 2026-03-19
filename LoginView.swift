import SwiftUI

@Observable
class LoginViewModel {
    var email = ""
    var password = ""
    var isLoading = false
    var showError = false
    var errorMessage = ""
    
    func login() {
        // Simple validation
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in all fields"
            showError = true
            return
        }
        guard email.contains("@") else {
            errorMessage = "Please enter a valid email"
            showError = true
            return
        }
        guard password.count >= 6 else {
            errorMessage = "Password must be at least 6 characters"
            showError = true
            return
        }
        
        isLoading = true
        // Simulate network request
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.isLoading = false
            // In a real app, you would handle the login response here
            // For now, just simulate success
            print("Login successful for \(self.email)")
            // TODO: Navigate to main app
        }
    }
}

struct LoginView: View {
    @State private var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Logo or App Name
                Text("Planix")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                
                Text("Manage your projects efficiently")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                // Email Field
                VStack(alignment: .leading, spacing: 8) {
                    Text("Email")
                        .font(.headline)
                    TextField("Enter your email", text: $viewModel.email)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }
                
                // Password Field
                VStack(alignment: .leading, spacing: 8) {
                    Text("Password")
                        .font(.headline)
                    SecureField("Enter your password", text: $viewModel.password)
                        .textFieldStyle(.roundedBorder)
                }
                
                // Error Message
                if viewModel.showError {
                    Text(viewModel.errorMessage)
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.top, 4)
                }
                
                // Login Button
                Button(action: {
                    viewModel.login()
                }) {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    } else {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .disabled(viewModel.isLoading)
                
                // Sign Up Link
                HStack {
                    Text("Don't have an account?")
                    Button("Sign Up") {
                        // TODO: Navigate to sign up screen
                    }
                    .fontWeight(.semibold)
                }
                .padding(.top, 20)
                
                Spacer()
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    LoginView()
}