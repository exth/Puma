import Foundation


enum AuthScreens: Hashable {
    case passwordView(email: String)
    case verificationCodeView(email: String)
}
