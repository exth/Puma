import Foundation


enum SignInPasswordError: LocalizedError, Equatable {
    case empty
    case invalidCredentials
    case custom(String)

    var errorDescription: String? {
        switch self {
        case .empty:
            return "Please enter your password"
        case .invalidCredentials:
            return "Incorrect email or password"
        case .custom(let message):
            return message
        }
    }
}
