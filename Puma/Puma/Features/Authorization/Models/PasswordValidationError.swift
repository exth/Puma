import Foundation


enum PasswordValidationError: LocalizedError {
    case empty
    case tooShort
    case missingNumber
    case missingCharacter
    case custom(String)

    var errorDescription: String? {
        switch self {
        case .empty:
            return "Please enter a password"
        case .tooShort:
            return "Password must be at least 10 characters"
        case .missingNumber:
            return "Password must contain a number"
        case .missingCharacter:
            return "Password must contain a special character"
        case .custom(let message):
            return message
        }
    }
}
