import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var showingForgotPassword = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                
                // Title
                Text("Login from Planix AI")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 40)
                
                // Email field
                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                // Password field
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                
                // Login button
                Button(action: login) {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    } else {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(email.isEmpty || password.isEmpty || isLoading)
                
                // Forgot password button
                Button("Forgot Password?") {
                    showingForgotPassword = true
                }
                .font(.footnote)
                .foregroundColor(.blue)
                .padding(.top, 10)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Login")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Forgot Password", isPresented: $showingForgotPassword) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Password reset functionality will be implemented soon.")
            }
        }
    }
    
    private func login() {
        isLoading = true
        // Simulate network request
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoading = false
            // Handle login logic
        }
    }
}

#Preview {
    LoginView()
}