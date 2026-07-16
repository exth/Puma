import Foundation


enum AuthServiceError: LocalizedError {
    case noCurrentUser
    case appleSignInCanceled
    case appleNonceMissing
    case appleIDTokenMissing
    case appleInvalidCredential
    case clientIDNotFound
    case noRootViewController
    case noIDToken
    case googleSignInCanceled

    var errorDescription: String? {
        switch self {
        case .noCurrentUser:
            return "User session not found. Please sign in again"
        case .appleSignInCanceled:
            return ""
        case .appleNonceMissing:
            return "Failed to prepare Apple sign-in"
        case .appleIDTokenMissing:
            return "Failed to get data from Apple"
        case .appleInvalidCredential:
            return "Invalid Apple Sign In credentials"
        case .clientIDNotFound:
            return "Google configuration error"
        case .noRootViewController:
            return "Unable to present sign-in screen"
        case .noIDToken:
            return "Failed to get data from Google"
        case .googleSignInCanceled:
            return ""
        }
    }
}
