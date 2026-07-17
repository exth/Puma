import Foundation
import Kingfisher


@Observable
final class ProfileViewModel {
    private let session: SessionManager
    private let cacheService: ProductCacheServiceProtocol
    
    var didClearCache = false
    
    init(session: SessionManager, cacheService: ProductCacheServiceProtocol = ProductCacheService.shared) {
        self.session = session
        self.cacheService = cacheService
    }
    
    
    func logOut() {
        session.logOut()
    }
    
    func clearCache() {
        cacheService.clearCache()
        ImageCache.default.clearCache()
        didClearCache = true
    }
}
