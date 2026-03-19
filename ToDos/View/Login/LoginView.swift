//
//  LoginView.swift
//  ToDos
//
//  Created by Planix iOS Developer on 19/03/2026.
//

import SwiftUI

@Observable
final class LoginViewModel {
    var email: String = ""
    var password: String = ""
    var isPasswordSecure: Bool = true
    var isLoading: Bool = false
    var didLogin: Bool = false

    var canSubmit: Bool {
        !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        password.count >= 6
    }

    func login() {
        guard canSubmit, !isLoading else { return }
        isLoading = true

        // Demo behavior.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { [weak self] in
            guard let self else { return }
            self.isLoading = false
            self.didLogin = true
        }
    }
}

struct LoginView: View {
    @State private var path: NavigationPath = NavigationPath()
    @State private var viewModel = LoginViewModel()

    var body: some View {
        NavigationStack(path: $path) {
            content
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Login")
                .navigationDestination(for: String.self) { _ in
                    // Placeholder for next screen.
                    Text("Logged in")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                }
                .onChange(of: viewModel.didLogin) { _, newValue in
                    guard newValue else { return }
                    path.append("logged-in")
                }
        }
    }

    @ViewBuilder
    private var content: some View {
        VStack(spacing: 20) {
            header

            VStack(alignment: .leading, spacing: 12) {
                TextField("Email", text: $viewModel.email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding(14)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

                HStack {
                    Group {
                        if viewModel.isPasswordSecure {
                            SecureField("Password", text: $viewModel.password)
                                .textContentType(.password)
                                .autocorrectionDisabled()
                        } else {
                            TextField("Password", text: $viewModel.password)
                                .textContentType(.password)
                                .autocorrectionDisabled()
                        }
                    }

                    Button {
                        withAnimation(.easeInOut(duration: 0.15)) {
                            viewModel.isPasswordSecure.toggle()
                        }
                    } label: {
                        Image(systemName: viewModel.isPasswordSecure ? "eye.slash" : "eye")
                            .foregroundStyle(.secondary)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel(viewModel.isPasswordSecure ? "Show password" : "Hide password")
                }
                .padding(14)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }

            Button {
                viewModel.login()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(.primary)
                    if viewModel.isLoading {
                        ProgressView()
                            .tint(.white)
                    } else {
                        Text("Sign in")
                            .font(.headline)
                            .foregroundStyle(.white)
                    }
                }
            }
            .frame(height: 48)
            .disabled(!viewModel.canSubmit || viewModel.isLoading)
            .opacity((!viewModel.canSubmit || viewModel.isLoading) ? 0.6 : 1)

            VStack(spacing: 6) {
                Button("Forgot password?") {
                    // Placeholder
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)

                Button("Create account") {
                    // Placeholder
                }
                .font(.subheadline)
            }
            .padding(.top, 6)

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 20)
        .padding(.top, 28)
        .padding(.bottom, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            LinearGradient(
                colors: [Color(uiColor: .systemGroupedBackground), Color(uiColor: .secondarySystemGroupedBackground)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        }
    }

    private var header: some View {
        VStack(spacing: 8) {
            Image(systemName: "lock.shield")
                .font(.system(size: 44, weight: .semibold))
                .foregroundStyle(.tint)

            Text("Welcome back")
                .font(.title2.weight(.semibold))

            Text("Sign in to continue")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    LoginView()
}
