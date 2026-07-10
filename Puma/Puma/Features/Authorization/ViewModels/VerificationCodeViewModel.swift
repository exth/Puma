import Foundation


@Observable
final class VerificationCodeViewModel {
    let email: String

    init(email: String) {
        self.email = email
    }
}
