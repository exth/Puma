import Foundation


@Observable
final class SignInViewModel {
    let email: String
    var password = ""
    var passwordError: SignInPasswordError?
    var isLoading = false
    var isShowingResetAlert = false

    private let coordinator: AuthFlowCoordinator
    private let session: SessionManager

    init(email: String, coordinator: AuthFlowCoordinator, session: SessionManager) {
        self.email = email
        self.coordinator = coordinator
        self.session = session
    }


    func continueTapped() {
        guard validatedPassword() else { return }

        // MARK: - здесь подключим Firebase >> sign-in
        session.completeAuthentication()
        coordinator.close()
    }

    func resetPasswordTapped() {
        // MARK: - здесь подключим Firebase >> sendPasswordReset
        isShowingResetAlert = true
    }


    private func validatedPassword() -> Bool {
        guard !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            passwordError = .empty
            return false
        }
        passwordError = nil
        return true
    }
}
