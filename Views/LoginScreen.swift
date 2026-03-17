import SwiftUI

struct LoginScreen: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    private var isCompact: Bool {
        horizontalSizeClass == .compact
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: isCompact ? 20 : 30) {
                    Spacer()
                    
                    // Title
                    Text("This is a login screen created from Planix")
                        .font(isCompact ? .largeTitle : .system(size: 40, weight: .bold))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, isCompact ? 20 : 60)
                    
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
                    .padding(.horizontal, isCompact ? 20 : geometry.size.width * 0.2)
                    
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
                    .padding(.horizontal, isCompact ? 20 : geometry.size.width * 0.2)
                    
                    // Forgot password button
                    HStack {
                        Spacer()
                        Button("Forgot Password?") {
                            // Action
                        }
                        .font(.footnote)
                        .foregroundColor(.blue)
                    }
                    .padding(.horizontal, isCompact ? 20 : geometry.size.width * 0.2)
                    
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
                    .padding(.horizontal, isCompact ? 20 : geometry.size.width * 0.3)
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
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                LoginScreen()
            }
            .previewDevice("iPhone 14")
            .previewDisplayName("iPhone 14")
            
            NavigationView {
                LoginScreen()
            }
            .previewDevice("iPad Pro (12.9-inch) (6th generation)")
            .previewDisplayName("iPad Pro")
            
            NavigationView {
                LoginScreen()
            }
            .previewDevice("iPhone 14")
            .previewDisplayName("Dark Mode")
            .preferredColorScheme(.dark)
        }
    }
}