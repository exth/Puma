import Foundation


enum SignInPasswordError: LocalizedError {
    case empty
    case invalidCredentials

    var errorDescription: String? {
        switch self {
        case .empty:
            return "Please enter your password"
        case .invalidCredentials:
            return "Incorrect email or password"
        }
    }
}
