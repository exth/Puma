#if DEBUG
import Foundation


final class MockProductCacheService: ProductCacheServiceProtocol {
    var cachedProducts: [Product]?
    
    func loadCachedProducts() -> [Product]? {
        cachedProducts
    }
    
    func saveProducts(_ products: [Product]) {
        cachedProducts = products
    }
    
    func clearCache() {
        cachedProducts = nil
    }
}
#endif
