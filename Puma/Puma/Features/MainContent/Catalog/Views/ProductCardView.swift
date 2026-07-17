import SwiftUI
import Kingfisher


struct ProductCardView: View {
    let product: Product
    
    // Пока что это чисто визуальный тогл. Когда будет избранное - будет vm.isFavorite(product)
    @State private var isFavorite = false
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            imageSection
            infoSection
        }
        .padding(10)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.borderDefault.opacity(0.3), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.1), radius: 8)
    }
    
    
    private var imageSection: some View {
        ZStack(alignment: .topTrailing) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.backgroundSecondary.opacity(0.5))
                .aspectRatio(1, contentMode: .fit)
                .overlay(
                    ZStack(alignment: .bottom) {
                        Ellipse()
                            .fill(Color.black.opacity(0.35))
                            .frame(width: 110, height: 8)
                            .blur(radius: 6)
                            .padding(.bottom, 28)
                            .allowsHitTesting(false)
                        
                        productImage
                            .padding(7)
                    }
                )
            
            favoriteButton
                .padding(8)
        }
    }
    
    private var productImage: some View {
        KFImage(URL(string: product.imageURL1))
            .placeholder {
                ProgressView()
            }
            .onFailure { _ in }
            .fade(duration: 0.25)
            .resizable()
            .scaledToFit()
    }
    
    private var favoriteButton: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isFavorite.toggle()
            }
        } label: {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(isFavorite ? .white : .black.opacity(0.6))
                .frame(width: 25, height: 25)
                .background(isFavorite ? Color.red : Color.white)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: isFavorite ? 2 : 0)
                )
                .shadow(color: .black.opacity(0.15), radius: 3)
        }
    }
    
    private var infoSection: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(product.name)
                .font(.subheadline)
                .fontWeight(.bold)
                .lineLimit(1)
            
            Text(product.type.rawValue)
                .font(.caption)
                .foregroundStyle(Color.textMuted)
            
            HStack(alignment: .center) {
                Text(product.price, format: .currency(code: "USD"))
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                
                Spacer()
                
                arrowButton
            }
            .padding(.top, 2)
        }
        .padding(.horizontal, 4)
    }
    
    private var arrowButton: some View {
        Image(systemName: "arrow.right")
            .font(.caption)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .frame(width: 26, height: 26)
            .background(Color.black.opacity(0.85))
            .clipShape(Circle())
    }
}


#Preview {
    ProductCardView(
        product: Product(
            id: "speedcat_og",
            name: "Speedcat OG",
            type: .lifestyle,
            price: 159.99,
            description: "",
            imageURL1: "",
            imageURL2: "",
            availableSizes: [40, 41],
            availableColors: ["black"]
        )
    )
    .frame(width: 170)
    .padding()
}
