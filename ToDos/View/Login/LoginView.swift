//
//  LoginView.swift
//  ToDos
//
//  Created by iOS Developer on 19/03/2026.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var isLoading: Bool = false
    @State private var errorMessage: String?

    @FocusState private var focusedField: Field?

    private enum Field {
        case email
        case password
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Welcome back")
                        .font(.system(.largeTitle, design: .rounded, weight: .bold))

                    Text("Log in to your account to continue.")
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                VStack(spacing: 12) {
                    emailField
                    passwordField

                    if let errorMessage {
                        Text(errorMessage)
                            .font(.footnote)
                            .foregroundStyle(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .transition(.opacity)
                    }

                    Button {
                        Task { await submit() }
                    } label: {
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(.circular)
                                .tint(.white)
                        } else {
                            Text("Log In")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(isLoading || !canSubmit)

                    Button {
                        // Placeholder action
                    } label: {
                        Text("Forgot password?")
                            .font(.footnote)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(.secondary)
                    .padding(.top, 4)
                }
                .padding(16)
                .background(Color(uiColor: .secondarySystemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

                Spacer(minLength: 0)

                Text("By continuing, you agree to our Terms and Privacy Policy.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.bottom, 8)
            }
            .padding(.horizontal, 20)
            .padding(.top, 32)
            .navigationTitle("Login")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private extension LoginView {
    var canSubmit: Bool {
        !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        password.count >= 6
    }

    var emailField: some View {
        TextField("Email", text: $email)
            .textInputAutocapitalization(.never)
            .keyboardType(.emailAddress)
            .textContentType(.emailAddress)
            .focused($focusedField, equals: .email)
            .submitLabel(.next)
            .onSubmit { focusedField = .password }
            .padding(12)
            .background(Color(uiColor: .systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }

    var passwordField: some View {
        Group {
            if showPassword {
                TextField("Password", text: $password)
                    .textInputAutocapitalization(.never)
                    .textContentType(.password)
            } else {
                SecureField("Password", text: $password)
                    .textInputAutocapitalization(.never)
                    .textContentType(.password)
            }
        }
        .focused($focusedField, equals: .password)
        .submitLabel(.done)
        .onSubmit { Task { await submit() } }
        .padding(12)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay(alignment: .trailing) {
            Button {
                withAnimation(.easeInOut(duration: 0.15)) {
                    showPassword.toggle()
                }
            } label: {
                Image(systemName: showPassword ? "eye.slash" : "eye")
                    .foregroundStyle(.secondary)
                    .padding(.trailing, 14)
            }
            .buttonStyle(.plain)
        }
    }

    @MainActor
    func submit() async {
        errorMessage = nil
        guard canSubmit else {
            errorMessage = "Please enter a valid email and a password of at least 6 characters."
            return
        }

        isLoading = true
        defer { isLoading = false }

        // Simulate network
        try? await Task.sleep(nanoseconds: 800_000_000)

        // Basic placeholder validation
        if email.lowercased() == "test@example.com" && password == "password" {
            // In a real app, we'd authenticate and transition to the app.
            // For now we just keep the user on the screen.
            errorMessage = nil
        } else {
            errorMessage = "Invalid credentials. Try again."
        }
    }
}

#Preview {
    LoginView()
}
