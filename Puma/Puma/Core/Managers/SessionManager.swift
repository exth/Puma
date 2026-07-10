import Foundation


enum AuthState {
    case firstLogin
    case loggedIn
    case loggedOut
}


@Observable
final class SessionManager {
    private(set) var authState: AuthState = .loggedOut
    
    private let hasSeenInfoKey = "hasCompledFirstLogin"
    private let userDefaults = UserDefaults.standard
    
    func login(isNewUser: Bool) {
        if isNewUser || !userDefaults.bool(forKey: hasSeenInfoKey) {
            authState = .firstLogin
        } else {
            authState = .loggedIn
        }
    }
    
    func infoSeen() {
        userDefaults.set(true, forKey: hasSeenInfoKey)
    }
    
    func logOut() {
        authState = .loggedOut
    }
}
