//
//  LoginView.swift
//  ToDos
//
//  Created by iOS Developer on 20/03/2026.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @FocusState private var focusedField: Field?

    // This is just a UI placeholder for the story. Hook it to real auth later.
    @State private var isAuthenticated: Bool = false

    enum Field {
        case email
        case password
    }

    var body: some View {
        Group {
            if isAuthenticated {
                HomeView()
            } else {
                loginContent
            }
        }
    }

    private var loginContent: some View {
        NavigationStack {
            VStack(spacing: 20) {
                VStack(spacing: 8) {
                    Text("Welcome back")
                        .font(.system(.largeTitle, design: .rounded, weight: .bold))
                        .multilineTextAlignment(.center)

                    Text("Sign in to continue")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 24)

                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Email")
                            .font(.footnote)
                            .foregroundStyle(.secondary)

                        TextField("name@example.com", text: $email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                            .textContentType(.emailAddress)
                            .focused($focusedField, equals: .email)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 12)
                            .background(Color(uiColor: .secondarySystemBackground), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Password")
                            .font(.footnote)
                            .foregroundStyle(.secondary)

                        SecureField("••••••••", text: $password)
                            .textContentType(.password)
                            .focused($focusedField, equals: .password)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 12)
                            .background(Color(uiColor: .secondarySystemBackground), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                }
                .padding(.horizontal)

                Button {
                    // Basic placeholder validation.
                    if !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                       !password.isEmpty {
                        withAnimation(.easeInOut) {
                            isAuthenticated = true
                        }
                    }
                } label: {
                    HStack {
                        Spacer()
                        Text("Sign In")
                            .font(.system(.headline, design: .rounded, weight: .semibold))
                        Spacer()
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal)
                .disabled(!isFormValid)

                Button {
                    // TODO: Implement forgot password flow.
                } label: {
                    Text("Forgot password?")
                        .font(.subheadline)
                        .foregroundStyle(.tint)
                }
                .padding(.top, 2)

                Spacer()

                Text("By continuing, you agree to our Terms & Privacy Policy.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
            }
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    HStack {
                        Spacer()
                        Button("Done") {
                            focusedField = nil
                        }
                    }
                }
            }
        }
    }

    private var isFormValid: Bool {
        !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !password.isEmpty
    }
}

#Preview {
    LoginView()
}
