import FirebaseAuth


extension NSError {
    var firebaseAuthErrorMessage: String {
        guard let errorCode = AuthErrorCode(rawValue: code) else {
            return "Something went wrong. Please try again later"
        }

        switch errorCode {
        case .invalidEmail:
            return "Invalid email address"
        case .emailAlreadyInUse:
            return "This email is already registered"
        case .weakPassword:
            return "Password must be at least 6 characters"
        case .wrongPassword, .invalidCredential:
            return "Incorrect email or password"
        case .userNotFound:
            return "No account found with this email"
        case .userDisabled:
            return "This account has been disabled"
        case .tooManyRequests:
            return "Too many attempts. Please try again later"
        case .networkError:
            return "Network error. Please check your connection"
        default:
            return "Something went wrong. Please try again later"
        }
    }
}
