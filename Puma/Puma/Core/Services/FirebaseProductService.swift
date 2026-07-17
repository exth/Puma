import FirebaseFirestore


final class FirebaseProductService: ProductServiceProtocol {
    private let db = Firestore.firestore()
    
    
    func fetchProducts() async throws -> [Product] {
        let snapshot = try await db.collection("products").getDocuments()
        return snapshot.documents.compactMap {
            Product(document: $0)
        }
    }
}


extension Product {
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let name = data["name"] as? String,
              let typeRaw = data["type"] as? String,
              let type = ProductType(rawValue: typeRaw),
              let price = data["price"] as? Double,
              let description = data["description"] as? String,
              let imageURL1 = data["imageURL1"] as? String,
              let imageURL2 = data["imageURL2"] as? String,
              let availableSizes = data["availableSizes"] as? [Int],
              let availableColors = data["availableColors"] as? [String] else {
            return nil
        }
        
        self.init(
            id: document.documentID,
            name: name,
            type: type,
            price: price,
            description: description,
            imageURL1: imageURL1,
            imageURL2: imageURL2,
            availableSizes: availableSizes,
            availableColors: availableColors
        )
    }
}
