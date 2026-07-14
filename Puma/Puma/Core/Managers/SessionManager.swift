import SwiftUI


enum AuthState: Equatable {
    case firstLogin
    case loggedIn
    case loggedOut
}


@Observable
final class SessionManager {
    private(set) var authState: AuthState = .loggedOut
    
    init() {
        restoreSession()
    }

    func restoreSession() {
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        
        withAnimation(.easeInOut(duration: 0.35)) {
            if isUserLoggedIn {
                authState = .loggedIn
            } else {
                authState = .loggedOut
            }
        }
    }

    func completeAuthentication() {
        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
        
        withAnimation(.easeInOut(duration: 0.35)) {
            authState = .firstLogin
        }
    }

    func logOut() {
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        
        withAnimation(.easeInOut(duration: 0.35)) {
            authState = .loggedOut
        }
    }
}
