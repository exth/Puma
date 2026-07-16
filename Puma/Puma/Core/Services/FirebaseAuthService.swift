import FirebaseAuth
import FirebaseCore
import GoogleSignIn


@Observable
final class FirebaseAuthService: AuthServiceProtocol {
    
    func signUp(email: String, password: String) async throws {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        try await result.user.sendEmailVerification()
    }
    
    func signIn(email: String, password: String) async throws {
        _ = try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func resendVerificationEmail() async throws {
        guard let user = Auth.auth().currentUser else {
            throw AuthServiceError.noCurrentUser
        }
        try await user.sendEmailVerification()
    }
    
    func reloadCurrentUser() async throws -> Bool {
        guard let user = Auth.auth().currentUser else {
            return false
        }
        try await user.reload()
        return user.isEmailVerified
    }
    
    func sendPasswordReset(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    
    func signInWithApple(idToken: String, rawNonce: String, fullName: PersonNameComponents?) async throws {
        let credential = OAuthProvider.appleCredential(
            withIDToken: idToken,
            rawNonce: rawNonce,
            fullName: fullName
        )
        
        try await Auth.auth().signIn(with: credential)
        
        if let fullName = fullName {
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            let formatter = PersonNameComponentsFormatter()
            changeRequest?.displayName = formatter.string(from: fullName)
            try await changeRequest?.commitChanges()
        }
    }
    
    
    func signInWithGoogle() async throws {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            throw AuthServiceError.clientIDNotFound
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let rootViewController = UIApplication.shared.mainWindowViewController() else {
            throw AuthServiceError.noRootViewController
        }
        
        do {
            let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            
            guard let idToken = result.user.idToken?.tokenString else {
                throw AuthServiceError.noIDToken
            }
            
            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: result.user.accessToken.tokenString
            )
            
            try await Auth.auth().signIn(with: credential)
        } catch {
            if let error = error as? GIDSignInError, error.code == .canceled {
                throw AuthServiceError.googleSignInCanceled
            }
            throw error
        }
    }
}
