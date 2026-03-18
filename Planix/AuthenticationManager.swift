import Foundation
import Observation

@Observable
class AuthenticationManager {
    var isAuthenticated = false
    
    func login(username: String, password: String) async -> Bool {
        // Simulate network call
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        // For demo, accept any non-empty credentials
        if !username.isEmpty && !password.isEmpty {
            isAuthenticated = true
            return true
        }
        return false
    }
    
    func logout() {
        isAuthenticated = false
    }
}