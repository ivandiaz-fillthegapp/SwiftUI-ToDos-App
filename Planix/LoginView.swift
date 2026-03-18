import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            // App logo or icon placeholder
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
                .padding(.bottom, 30)
            
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
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .frame(maxWidth: .infinity)
                } else {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(email.isEmpty || password.isEmpty || isLoading)
            .padding(.top, 10)
            
            // Forgot password
            Button("Forgot Password?") {
                // TODO: Implement forgot password action
                alertMessage = "Forgot password functionality not yet implemented."
                showAlert = true
            }
            .font(.subheadline)
            .foregroundColor(.blue)
            
            Spacer()
        }
        .padding(.horizontal, 30)
        .alert("Info", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }
    
    private func login() {
        isLoading = true
        // Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoading = false
            // TODO: Implement actual authentication logic
            alertMessage = "Login successful (simulated)."
            showAlert = true
        }
    }
}

#Preview {
    LoginView()
}