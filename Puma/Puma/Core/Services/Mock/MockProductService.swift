#if DEBUG
import Foundation


final class MockProductService: ProductServiceProtocol {
    var productsToReturn: [Product] = []
    var errorToThrow: Error?
    
    
    func fetchProducts() async throws -> [Product] {
        if let errorToThrow {
            throw errorToThrow
        }
        return productsToReturn
    }
}
#endif
