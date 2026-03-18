import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                SecureField("Password", text: $password)
            } header: {
                Text("Login from Planix AI")
                    .font(.largeTitle)
                    .textCase(nil)
                    .padding(.bottom, 10)
            }
            
            Section {
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
            }
            
            Section {
                Button("Forgot Password?") {
                    alertMessage = "Forgot password functionality not yet implemented."
                    showAlert = true
                }
                .frame(maxWidth: .infinity)
                .foregroundColor(.blue)
            }
        }
        .navigationTitle("Login")
        .navigationBarTitleDisplayMode(.inline)
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
            alertMessage = "Login successful (simulated)."
            showAlert = true
        }
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
}