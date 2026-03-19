import Foundation
import SwiftUI

@Observable
class LoginViewModel {
    var email = ""
    var password = ""
    var isLoading = false
    var errorMessage: String?
    var isLoggedIn = false
    
    func login() {
        isLoading = true
        errorMessage = nil
        // Simulate network request
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.isLoading = false
            if self.email.isEmpty || self.password.isEmpty {
                self.errorMessage = "Please fill in all fields"
            } else if self.email == "test@example.com" && self.password == "password" {
                self.isLoggedIn = true
            } else {
                self.errorMessage = "Invalid credentials"
            }
        }
    }
}