#if DEBUG
import Foundation


final class MockAuthService: AuthServiceProtocol {
    var signUpCalled = false
    var signInCalled = false
    var resendVerificationCalled = false
    var reloadCurrentUserCalled = false
    var sendPasswordResetCalled = false
    var signInWithGoogleCalled = false
 
    var errorToThrow: Error?
    var isEmailVerifiedToReturn = false
 
    
    func signUp(email: String, password: String) async throws {
        signUpCalled = true
        if let errorToThrow {
            throw errorToThrow
        }
    }
 
    func signIn(email: String, password: String) async throws {
        signInCalled = true
        if let errorToThrow {
            throw errorToThrow
        }
    }
 
    func resendVerificationEmail() async throws {
        resendVerificationCalled = true
        if let errorToThrow {
            throw errorToThrow
        }
    }
 
    func reloadCurrentUser() async throws -> Bool {
        reloadCurrentUserCalled = true
        if let errorToThrow {
            throw errorToThrow
        }
        return isEmailVerifiedToReturn
    }
 
    func sendPasswordReset(email: String) async throws {
        sendPasswordResetCalled = true
        if let errorToThrow {
            throw errorToThrow
        }
    }
 
    func signInWithApple(idToken: String, rawNonce: String, fullName: PersonNameComponents?) async throws {
        if let errorToThrow {
            throw errorToThrow
        }
    }
 
    func signInWithGoogle() async throws {
        signInWithGoogleCalled = true
        if let errorToThrow {
            throw errorToThrow
        }
    }
}
#endif
