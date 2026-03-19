//
//  LoginViewModel.swift
//  ToDos
//
//  Created by iOS Developer on 19/03/2026.
//

import Foundation

@Observable
final class LoginViewModel {
    var email: String = ""
    var password: String = ""
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    func signIn() async {
        errorMessage = nil
        isLoading = true
        defer { isLoading = false }
        
        try? await Task.sleep(for: .milliseconds(500))
        
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedEmail.isEmpty || password.isEmpty {
            errorMessage = "Please enter your email and password."
            return
        }
        
        if !trimmedEmail.contains("@") {
            errorMessage = "Please enter a valid email."
            return
        }
    }
}
