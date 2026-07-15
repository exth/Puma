import Foundation


@Observable
final class PasswordInputViewModel {
    private let coordinator: AuthFlowCoordinator
    private let authService: AuthServiceProtocol
    
    let email: String
    var password = ""
    var validationError: PasswordValidationError?
    var isLoading = false
    
    
    init(email: String, coordinator: AuthFlowCoordinator, authService: AuthServiceProtocol) {
        self.email = email
        self.coordinator = coordinator
        self.authService = authService
    }
    
    
    func continueTapped() {
        guard let validPassword = validatedPassword() else {
            return
        }

        Task {
            isLoading = true
            validationError = nil

            do {
                try await authService.signUp(email: email, password: validPassword)
                coordinator.showVerificationCodeView(email: email)
            } catch {
                validationError = .custom((error as NSError).firebaseAuthErrorMessage)
            }

            isLoading = false
        }
    }
    
    private func validatedPassword() -> String? {
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedPassword.isEmpty else {
            validationError = .empty
            return nil
        }
        
        guard trimmedPassword.count >= 10 else {
            validationError = .tooShort
            return nil
        }
        
        guard trimmedPassword.contains(where: { $0.isNumber }) else {
            validationError = .missingNumber
            return nil
        }
        
        let specialCharacters = CharacterSet(charactersIn: "!@#$%^&*()_+-=[]{}|;:'\",.<>/?`~\\")
        guard trimmedPassword.rangeOfCharacter(from: specialCharacters) != nil else {
            validationError = .missingCharacter
            return nil
        }
        
        validationError = nil
        return trimmedPassword
    }
}
