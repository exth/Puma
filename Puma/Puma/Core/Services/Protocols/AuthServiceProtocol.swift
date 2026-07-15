import Foundation


protocol AuthServiceProtocol {
    func signUp(email: String, password: String) async throws
    func signIn(email: String, password: String) async throws
    func resendVerificationEmail() async throws
    func reloadCurrentUser() async throws -> Bool
    func sendPasswordReset(email: String) async throws

    func signInWithApple(idToken: String, rawNonce: String, fullName: PersonNameComponents?) async throws
}
