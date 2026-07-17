import Foundation
 
 
protocol ProductServiceProtocol {
    func fetchProducts() async throws -> [Product]
}
