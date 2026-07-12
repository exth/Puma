import Foundation


enum EmailValidationError: LocalizedError {
    case empty
    case invalidFormat
    
    var errorDescription: String? {
        switch self {
        case .empty:
            return "Please enter your email"
        case .invalidFormat:
            return "Please enter a valid email address"
        }
    }
}
