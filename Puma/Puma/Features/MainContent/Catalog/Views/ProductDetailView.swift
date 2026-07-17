import SwiftUI


struct ProductDetailView: View {
    let product: Product
    
    var body: some View {
        VStack {
            Text(product.name)
        }
    }
}


#Preview {
    NavigationStack {
        ProductDetailView(
            product: Product(
                id: "speedcat_og",
                name: "Speedcat OG",
                type: .lifestyle,
                price: 159.99,
                description: "",
                imageURL1: "",
                imageURL2: "",
                availableSizes: [39, 40, 41],
                availableColors: ["black"]
            )
        )
    }
}
