import SwiftUI
import Kingfisher


struct ProductCardView: View {
    @State private var vm: ProductCardViewModel
    
    init(product: Product, favoritesManager: FavoritesManager) {
        _vm = State(initialValue: ProductCardViewModel(product: product, favoritesManager: favoritesManager))
    }
    
    
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
            
            FavoriteButtonView(isFavorite: vm.isFavorite) {
                vm.toggleFavorite()
            }
            .padding(8)
        }
    }
    
    private var productImage: some View {
        KFImage(URL(string: vm.product.imageURL1))
            .placeholder {
                ProgressView()
            }
            .onFailure { _ in }
            .fade(duration: 0.25)
            .resizable()
            .scaledToFit()
    }
    
    private var infoSection: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(vm.product.name)
                .font(.subheadline)
                .fontWeight(.bold)
                .lineLimit(1)
            
            Text(vm.product.type.rawValue)
                .font(.caption)
                .foregroundStyle(Color.textMuted)
            
            HStack(alignment: .center) {
                Text(vm.product.price, format: .currency(code: "USD"))
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
            availableColors: ["black"]),
        favoritesManager: FavoritesManager()
    )
    .frame(width: 170)
    .padding()
    .environment(FavoritesManager())
}
