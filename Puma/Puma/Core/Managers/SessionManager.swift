import Foundation


enum AuthState {
    case firstLogin
    case loggedIn
    case loggedOut
}


@Observable
final class SessionManager {
    private(set) var authState: AuthState = .loggedOut
    
    private let hasSeenInfoKey = "hasCompleetdFirstLogin" // 1) Что это и зачем
    private let userDefaults = UserDefaults.standard
    
    func login(isNewUser: Bool) {
        if isNewUser || !userDefaults.bool(forKey: hasSeenInfoKey) { // 2) зачем нам проверка, котороая после ||?
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
