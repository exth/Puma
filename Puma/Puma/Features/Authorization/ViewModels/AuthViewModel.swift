import Foundation
import AuthenticationServices


@Observable
final class AuthViewModel {
    private let session: SessionManager
    private let authService: AuthServiceProtocol
    
    var isShowingEmailInput = false
    var isLoading = false
    var errorMessage: String?
    
    init(session: SessionManager, authService: AuthServiceProtocol) {
        self.session = session
        self.authService = authService
    }
    
    
    func showEmailInput() {
        isShowingEmailInput = true
    }
    
    func handleAppleSignIn(result: Result<ASAuthorization, Error>, nonce: String?) async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        
        switch result {
        case .success(let authorization):
            guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
                errorMessage = AuthServiceError.appleInvalidCredential.errorDescription
                return
            }
            
            guard let appleIDToken = appleIDCredential.identityToken,
                  let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                errorMessage = AuthServiceError.appleIDTokenMissing.errorDescription
                return
            }
            
            guard let nonce = nonce else {
                errorMessage = AuthServiceError.appleNonceMissing.errorDescription
                return
            }
            
            do {
                try await authService.signInWithApple(
                    idToken: idTokenString,
                    rawNonce: nonce,
                    fullName: appleIDCredential.fullName
                )
                session.completeAuthentication()
            } catch {
                errorMessage = (error as NSError).firebaseAuthErrorMessage
            }
            
        case .failure(let error):
            if let authError = error as? ASAuthorizationError, authError.code == .canceled {
                errorMessage = nil
            } else {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func signInWithGoogle() async {
        isLoading = true
        errorMessage = nil
        defer {
            isLoading = false
        }
        
        do {
            try await authService.signInWithGoogle()
            session.completeAuthentication()
        } catch AuthServiceError.googleSignInCanceled {
        } catch let authError as AuthServiceError {
            errorMessage = authError.errorDescription
        } catch {
            errorMessage = (error as NSError).firebaseAuthErrorMessage
        }
    }
}
