import Foundation


final class EmailInputViewModel {
    var email = ""
    var errorMessage: String?
    
    
    func continueTapped(coordinator: AuthFlowCoordinator) {
        guard isValidEmail(email) else {
            errorMessage = "Введите корректный email"
            return
        }
        coordinator.showPasswordView(email: email)
    }
    
    // MARK: CДЕЛАТЬ НОРМАЛЬНУЮ ПРОВЕРКУ
    private func isValidEmail(_ email: String) -> Bool {
        email.contains("@") && email.contains(".")
        // !!>> заменить на нормальную regex-проверку
    }
}
