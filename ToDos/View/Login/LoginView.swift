//
//  LoginView.swift
//  ToDos
//
//  Created by iOS Developer on 19/03/2026.
//

import SwiftUI

struct LoginView: View {
    @State private var viewModel = LoginViewModel()
    
    @FocusState private var focusedField: Field?
    
    enum Field {
        case email
        case password
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                header
                form
                signInButton
                errorView
                Spacer(minLength: 0)
            }
            .padding(.horizontal, 20)
            .padding(.top, 28)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private extension LoginView {
    var header: some View {
        VStack(spacing: 8) {
            Image(systemName: "lock.shield")
                .font(.system(size: 44, weight: .semibold))
                .foregroundStyle(.tint)
                .padding(.bottom, 6)
            Text("Welcome back")
                .font(.system(.title, design: .rounded, weight: .bold))
            Text("Sign in to continue")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    var form: some View {
        VStack(spacing: 12) {
            TextField("Email", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .textContentType(.emailAddress)
                .focused($focusedField, equals: .email)
                .submitLabel(.next)
                .onSubmit { focusedField = .password }
                .padding(12)
                .background {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color(uiColor: .secondarySystemBackground))
                }

            SecureField("Password", text: $viewModel.password)
                .textContentType(.password)
                .focused($focusedField, equals: .password)
                .submitLabel(.go)
                .onSubmit { Task { await viewModel.signIn() } }
                .padding(12)
                .background {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color(uiColor: .secondarySystemBackground))
                }
        }
    }

    var signInButton: some View {
        Button {
            Task { await viewModel.signIn() }
        } label: {
            HStack {
                if viewModel.isLoading {
                    ProgressView()
                        .tint(.white)
                }
                Text(viewModel.isLoading ? "Signing in" : "Sign in")
                    .frame(maxWidth: .infinity)
            }
        }
        .buttonStyle(.borderedProminent)
        .disabled(viewModel.isLoading)
        .controlSize(.large)
        .padding(.top, 6)
    }

    var errorView: some View {
        Group {
            if let message = viewModel.errorMessage {
                Text(message)
                    .font(.callout)
                    .foregroundStyle(.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    LoginView()
}
