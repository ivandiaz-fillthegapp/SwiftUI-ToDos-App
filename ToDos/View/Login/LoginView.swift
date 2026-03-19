//
//  LoginView.swift
//  ToDos
//
//  Created by iOS Developer on 03/19/2026.
//

import SwiftUI

@Observable final class LoginViewModel {
    var email: String = ""
    var password: String = ""
    var isLoading: Bool = false
    var errorMessage: String? = nil

    var canSubmit: Bool {
        let trimmed = email.trimmingCharacters(in: .whitespacesAndNewlines)
        return !trimmed.isEmpty && !password.isEmpty
    }

    func submit() async {
        errorMessage = nil
        isLoading = true
        defer { isLoading = false }

        // Temporary mock validation.
        try? await Task.sleep(nanoseconds: 500_000_000)

        let trimmed = email.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmed.contains("@") {
            errorMessage = "Please enter a valid email."
            return
        }
        if password.count < 6 {
            errorMessage = "Password must be at least 6 characters."
            return
        }

        // Success (integration can be done later).
    }
}

struct LoginView: View {
    @State private var viewModel = LoginViewModel()
    @FocusState private var focusedField: Field?

    private enum Field {
        case email
        case password
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                header

                VStack(spacing: 12) {
                    emailField
                    passwordField
                }
                .padding(.top, 8)

                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .font(.callout)
                        .foregroundStyle(.red)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .transition(.opacity)
                }

                submitButton

                Spacer(minLength: 0)

                footer
            }
            .padding(.horizontal, 20)
            .padding(.top, 32)
            .navigationTitle("Sign In")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private extension LoginView {
    var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Welcome back")
                .font(.largeTitle.weight(.bold))
            Text("Sign in to continue to your lists.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    var emailField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Email")
                .font(.callout)
                .foregroundStyle(.secondary)

            TextField("name@example.com", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .textContentType(.emailAddress)
                .focused($focusedField, equals: .email)
                .padding(12)
                .background(Color(uiColor: .secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
    }

    var passwordField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Password")
                .font(.callout)
                .foregroundStyle(.secondary)

            SecureField("••••••", text: $viewModel.password)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .textContentType(.password)
                .focused($focusedField, equals: .password)
                .padding(12)
                .background(Color(uiColor: .secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
    }

    var submitButton: some View {
        Button {
            Task { await viewModel.submit() }
        } label: {
            HStack {
                Spacer()
                if viewModel.isLoading {
                    ProgressView()
                        .tint(.white)
                } else {
                    Text("Sign In")
                        .font(.headline.weight(.semibold))
                        .foregroundStyle(.white)
                }
                Spacer()
            }
            .padding(.vertical, 14)
        }
        .background(viewModel.canSubmit ? Color.accentColor : Color.gray.opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .disabled(!viewModel.canSubmit || viewModel.isLoading)
        .animation(.easeInOut(duration: 0.2), value: viewModel.canSubmit)
    }

    var footer: some View {
        VStack(spacing: 10) {
            Button("Forgot password?") {
                // Placeholder action.
            }
            .font(.callout)
            .foregroundStyle(.secondary)

            HStack(spacing: 6) {
                Text("Don’t have an account?")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                Button("Sign up") {
                    // Placeholder action.
                }
                .font(.callout.weight(.semibold))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 8)
    }
}

#Preview {
    LoginView()
}
