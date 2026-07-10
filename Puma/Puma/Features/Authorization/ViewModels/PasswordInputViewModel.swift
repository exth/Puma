import Foundation


@Observable
final class PasswordInputViewModel {
    private let coordinator: AuthFlowCoordinator
    
    let email: String
    var password = ""
    var errorMessage: String?
    
    
    init(email: String, coordinator: AuthFlowCoordinator) {
        self.email = email
        self.coordinator = coordinator
    }
    
    
    // MARK: - добавить нормальную валидацию пароля -
    func continueTupped() {
        guard password.count >= 6 else {
            errorMessage = "Пароль должен быть не короче 6 символов"
            return
        }
        coordinator.showVerificationCodeView(email: email)
    }
}
