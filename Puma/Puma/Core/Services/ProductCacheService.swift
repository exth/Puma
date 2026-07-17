import Foundation


final class ProductCacheService: ProductCacheServiceProtocol {
    static let shared = ProductCacheService()
    private init() {}
    
    private let fileName = "productsСache.json"
    
    private var fileURL: URL? {
        FileManager.default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(fileName)
    }
    
    
    func loadCachedProducts() -> [Product]? {
        guard let fileURL,
              let data = try? Data(contentsOf: fileURL),
              let products = try? JSONDecoder().decode([Product].self, from: data)
        else {
            return nil
        }
        return products
    }
    
    func saveProducts(_ products: [Product]) {
        guard let fileURL,
              let data = try? JSONEncoder().encode(products)
        else {
            return
        }
        
        try? data.write(to: fileURL, options: .atomic)
    }
    
    func clearCache() {
        guard let fileURL, FileManager.default.fileExists(atPath: fileURL.path) else {
            return
        }
        try? FileManager.default.removeItem(at: fileURL)
    }
}
