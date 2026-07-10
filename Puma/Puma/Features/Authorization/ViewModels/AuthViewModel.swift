import Foundation


@Observable
final class AuthViewModel {
    var email = ""
    var password = ""
    var errorMessage: String?  // 8) сделать enum с возможными ошибками
    
    private let session: SessionManager
    
    init(session: SessionManager) {
        self.session = session
    }
    
    
    func login() {
        // MARK: -9) реализовать тут обращение к серверу?-
        let isNewUser = false
        session.login(isNewUser: isNewUser)
    }
    
    func register() {
        // MARK: -10) реализовать тут обращение с верверу?-
        let isNewUser = true
        session.login(isNewUser: isNewUser)
    }
}
