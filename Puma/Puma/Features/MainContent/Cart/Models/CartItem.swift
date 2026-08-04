import Foundation


struct CartItem: Codable, Identifiable, Hashable {
    let id: String
    let product: Product
    let selectedSize: Int
    let selectedColor: String
}
