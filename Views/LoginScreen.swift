import SwiftUI

struct LoginScreen: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 20) {
                    Spacer()
                    
                    // Title
                    Text("This is a login screen created from Planix")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    // Email field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        TextField("Enter your email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding(.horizontal)
                    
                    // Password field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        HStack {
                            if isPasswordVisible {
                                TextField("Enter your password", text: $password)
                            } else {
                                SecureField("Enter your password", text: $password)
                            }
                            Button(action: {
                                isPasswordVisible.toggle()
                            }) {
                                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                    .foregroundColor(.secondary)
                            }
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding(.horizontal)
                    
                    // Forgot password button
                    HStack {
                        Spacer()
                        Button("Forgot Password?") {
                            // Action
                        }
                        .font(.footnote)
                        .foregroundColor(.blue)
                    }
                    .padding(.horizontal)
                    
                    // Login button
                    Button(action: {
                        // Login action
                        print("Login tapped with email: \(email)")
                    }) {
                        Text("Login")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .disabled(email.isEmpty || password.isEmpty)
                    .opacity(email.isEmpty || password.isEmpty ? 0.6 : 1.0)
                    
                    // Sign up button
                    HStack {
                        Text("Don't have an account?")
                            .foregroundColor(.secondary)
                        Button("Sign Up") {
                            // Sign up action
                        }
                        .foregroundColor(.blue)
                    }
                    .font(.subheadline)
                    .padding(.top, 10)
                    
                    Spacer()
                }
                .frame(minHeight: geometry.size.height)
            }
        }
        .navigationBarTitle("Login", displayMode: .inline)
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginScreen()
        }
    }
}