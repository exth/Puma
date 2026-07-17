import Foundation


protocol ProductCacheServiceProtocol {
    func loadCachedProducts() -> [Product]?
    func saveProducts(_ products: [Product])
    func clearCache()
}
