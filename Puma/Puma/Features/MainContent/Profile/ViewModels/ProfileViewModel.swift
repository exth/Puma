import Foundation
import Kingfisher


@Observable
final class ProfileViewModel {
    private let session: SessionManager
    private let cacheService: ProductCacheServiceProtocol
    private let authService: AuthServiceProtocol
    
    var didClearCache = false
    var isShowingOrderHistoryAlert = false
    var isShowingDeleteAccountAlert = false
    var isShowingFinalDeleteAccountAlert = false
    var isDeletingAccount = false
    var deleteAccountError: String?
    var isShowingSignOutAlert = false
    
    init(
        session: SessionManager,
        cacheService: ProductCacheServiceProtocol = ProductCacheService.shared,
        authService: AuthServiceProtocol = FirebaseAuthService()
    ) {
        self.session = session
        self.cacheService = cacheService
        self.authService = authService
    }
    
    
    var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
        return "App version - \(version) (\(build))"
    }
    
    
    func orderHistoryTapped() {
        isShowingOrderHistoryAlert = true
    }
    
    func clearCache() {
        cacheService.clearCache()
        ImageCache.default.clearCache()
        didClearCache = true
    }
    
    func signOutTapped() {
        isShowingSignOutAlert = true
    }
    
    func confirmSignOut() {
        session.logOut()
    }
    
    func deleteAccountTapped() {
        isShowingDeleteAccountAlert = true
    }
    
    func confirmDeleteAccountFirstStep() {
        isShowingFinalDeleteAccountAlert = true
    }
    
    func confirmDeleteAccountFinalStep() {
        Task {
            isDeletingAccount = true
            deleteAccountError = nil
            
            do {
                try await authService.deleteAccount()
                session.logOut()
            } catch {
                deleteAccountError = (error as NSError).firebaseAuthErrorMessage
            }
            
            isDeletingAccount = false
        }
    }
}
