import SwiftUI


@Observable
final class AuthFlowCoordinator {
    var path = NavigationPath()
    
    var onClose: (() -> Void)?
    
    
    func showPasswordView(email: String) {
        path.append(AuthScreens.passwordView(email: email))
    }
    
    func showVerificationCodeView(email: String) {
        path.append(AuthScreens.verificationCodeView(email: email))
    }
    
    func goBack() {
        path.removeLast()
    }
    
    func close() {
         onClose?()
     }
}
