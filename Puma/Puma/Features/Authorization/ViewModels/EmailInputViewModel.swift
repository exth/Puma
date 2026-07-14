import Foundation


@Observable
final class EmailInputViewModel {
    var email = ""
    var validationError: EmailValidationError?


    func continueTapped(coordinator: AuthFlowCoordinator) {
        guard let validEmail = validatedEmail() else { return }
        coordinator.showSignInView(email: validEmail)
    }

    func createAccountTapped(coordinator: AuthFlowCoordinator) {
        guard let validEmail = validatedEmail() else { return }
        coordinator.showPasswordView(email: validEmail)
    }

    private func validatedEmail() -> String? {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedEmail.isEmpty else {
            validationError = .empty
            return nil
        }
        guard isValidFormat(trimmedEmail) else {
            validationError = .invalidFormat
            return nil
        }
        validationError = nil
        return trimmedEmail
    }

    private func isValidFormat(_ email: String) -> Bool {
        let pattern = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}$"#
        return email.range(of: pattern, options: .regularExpression) != nil
    }
}
