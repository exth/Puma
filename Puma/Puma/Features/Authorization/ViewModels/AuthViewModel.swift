import Foundation


@Observable
final class AuthViewModel {
    private let session: SessionManager
    
    var isShowingEmailInput = false

    init(session: SessionManager) {
        self.session = session
    }

    
    // MARK: интегрировать Apple
    func continueWithApple() { }

    // MARK: интегрировать Google
    func continueWithGoogle() { }

    func showEmailInput() {
        isShowingEmailInput = true
    }
}
