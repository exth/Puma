import Foundation


@Observable
final class PasswordInputViewModel {
    private let coordinator: AuthFlowCoordinator
    
    let email: String
    var password = ""
    var validationError: PasswordValidationError?
    
    
    init(email: String, coordinator: AuthFlowCoordinator) {
        self.email = email
        self.coordinator = coordinator
    }
    
    
    func continueTapped() {
        guard let validPassword = validatedPassword() else { 
            return
        }
        // MARK: - обновить, когда появится сервис -
        _ = validPassword // передать в запрос на сервер, когда будет сервис

        coordinator.showVerificationCodeView(email: email)
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

