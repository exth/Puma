import SwiftUI
import Kingfisher


struct ProductDetailView: View {
    @State private var vm: ProductDetailViewModel
    @State private var isFavorite = false
    @Environment(\.dismiss) private var dismiss
    
    private let imageCardHeight: CGFloat = 250
    
    init(product: Product) {
        _vm = State(initialValue: ProductDetailViewModel(product: product))
    }
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                imageSection
                priceSection
                sizeSection
                colorSection
                descriptionSection
                actionButtons
            }
            .padding()
        }
        .scrollIndicators(.hidden)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
            }
            
            ToolbarItem(placement: .principal) {
                AppLogoView(size: 80)
            }
            
            // TODO: реализовать
//            ToolbarItem(placement: .topBarTrailing) {
//                FavoriteButtonView(isFavorite: $isFavorite, size: 28, showsShadow: false)
//            }
        }
        .appBackground()
        .unavailableFeatureAlert(isPresented: $vm.isShowingUnavailableAlert)
    }
    
    
    private var imageSection: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.backgroundSecondary)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.borderDefault, lineWidth: 2)
            )
            .shadow(color: .black.opacity(0.1), radius: 5)
            .overlay(imagesTabView)
            .frame(maxWidth: .infinity)
            .frame(height: imageCardHeight)
    }
    
    private var imagesTabView: some View {
        TabView(selection: $vm.selectedImageIndex) {
            productImage(vm.product.imageURL1)
                .tag(0)
            
            productImage(vm.product.imageURL2)
                .tag(1)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .overlay(alignment: .bottom) {
            pageIndicator
                .padding(.bottom, 16)
        }
    }
    
    private func productImage(_ urlString: String) -> some View {
        ZStack(alignment: .bottom) {
            Ellipse()
                .fill(Color.black.opacity(0.35))
                .frame(width: 200, height: 10)
                .blur(radius: 8)
                .padding(.bottom, 50)
                .allowsHitTesting(false)
            
//            Image("qqq")
//                .resizable()
//                .scaledToFit()
            
            KFImage(URL(string: urlString))
                .placeholder {
                    ProgressView()
                }
                .onFailure { _ in }
                .fade(duration: 0.25)
                .resizable()
                .scaledToFit()
        }
    }
    
    private var pageIndicator: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(Color.black.opacity(vm.selectedImageIndex == 0 ? 0.8 : 0.25))
                .frame(width: 6, height: 6)
            
            Circle()
                .fill(Color.black.opacity(vm.selectedImageIndex == 1 ? 0.8 : 0.25))
                .frame(width: 6, height: 6)
        }
    }
    
    private var priceSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(vm.product.name)
                .font(.title2)
                .fontWeight(.bold)
            
            HStack(spacing: 8) {
                Text(vm.product.price, format: .currency(code: "USD"))
                    .font(.title3)
                    .fontWeight(.bold)
                
                Text(vm.originalPrice, format: .currency(code: "USD"))
                    .font(.subheadline)
                    .foregroundStyle(Color.textMuted)
                    .strikethrough()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var sizeSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Choose size")
                .font(.caption)
            
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(vm.allSizes, id: \.self) { size in
                        SizeChipView(
                            size: size,
                            isAvailable: vm.isSizeAvailable(size),
                            isSelected: vm.selectedSize == size
                        ) {
                            vm.selectSize(size)
                        }
                    }
                }
                .padding(2)
            }
            .scrollIndicators(.hidden)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var colorSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Choose color")
                .font(.caption)
            
            HStack(spacing: 12) {
                ForEach(vm.allColors) { color in
                    ColorSwatchView(
                        color: color,
                        isAvailable: vm.isColorAvailable(color),
                        isSelected: vm.selectedColor == color
                    ) {
                        vm.selectColor(color)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Product Description")
                .font(.caption)
            
            Text(vm.product.description)
                .font(.subheadline)
                .foregroundStyle(Color.textSecondary)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.borderDefault.opacity(0.3), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.1), radius: 8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var actionButtons: some View {
        HStack(spacing: 12) {
            Button {
                vm.buyNowTapped()
            } label: {
                Text("Buy now")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(.vertical, 14)
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .disabled(!vm.canPurchase)
            .opacity(vm.canPurchase ? 1 : 0.4)
            
            Button {
                // TODO: реализовать, когда появится корзина
            } label: {
                Text("Add to cart")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .padding(.vertical, 14)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.borderDefault, lineWidth: 2)
                    )
            }
            .disabled(!vm.canPurchase)
            .opacity(vm.canPurchase ? 1 : 0.4)
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
                description: "A timeless silhouette reimagined for everyday wear, blending retro racing heritage with modern comfort.",
                imageURL1: "",
                imageURL2: "",
                availableSizes: [38, 39, 41, 43],
                availableColors: ["black", "red"]
            )
        )
    }
}
