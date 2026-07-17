import Foundation


struct Product: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let type: ProductType
    let price: Double
    let description: String
    let imageURL1: String
    let imageURL2: String
    let availableSizes: [Int]
    let availableColors: [String]
}
