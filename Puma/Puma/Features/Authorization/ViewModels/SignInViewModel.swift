import Foundation


@Observable
final class SignInViewModel {
    let email: String
    var password = ""
    var passwordError: SignInPasswordError?
    var isLoading = false
    var isShowingResetAlert = false
    
    var isSendingResetLink = false
    var resetError: String?
    
    private let coordinator: AuthFlowCoordinator
    private let session: SessionManager
    private let authService: AuthServiceProtocol
    
    init(email: String, coordinator: AuthFlowCoordinator, session: SessionManager, authService: AuthServiceProtocol) {
        self.email = email
        self.coordinator = coordinator
        self.session = session
        self.authService = authService
    }
    
    
    func continueTapped() {
        guard validatedPassword() else {
            return
        }
        
        Task {
            isLoading = true
            passwordError = nil
            resetError = nil
            
            do {
                try await authService.signIn(email: email, password: password)
                coordinator.close()
                try? await Task.sleep(nanoseconds: 350_000_000)
                session.completeAuthentication()
            } catch {
                passwordError = .custom((error as NSError).firebaseAuthErrorMessage)
            }
            
            isLoading = false
        }
    }
    
    func resetPasswordTapped() {
        guard !isSendingResetLink else {
            return
        }
        
        Task {
            isSendingResetLink = true
            resetError = nil
            passwordError = nil
            
            do {
                try await authService.sendPasswordReset(email: email)
                isShowingResetAlert = true
            } catch {
                resetError = (error as NSError).firebaseAuthErrorMessage
            }
            
            isSendingResetLink = false
        }
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
