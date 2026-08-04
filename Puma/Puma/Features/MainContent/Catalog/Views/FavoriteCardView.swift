import SwiftUI
import Kingfisher


struct FavoriteCardView: View {
    @State private var vm: FavoriteCardViewModel
    @Environment(CartManager.self) private var cartManager
    let onRemoveFavorite: () -> Void
    
    init(product: Product, onRemoveFavorite: @escaping () -> Void) {
        _vm = State(initialValue: FavoriteCardViewModel(product: product))
        self.onRemoveFavorite = onRemoveFavorite
    }
    
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(alignment: .top, spacing: 12) {
                imageSection
                infoSection
            }
        }
        .padding(10)
        .background(Color.white.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.borderDefault.opacity(0.7), lineWidth: 2)
        )
        .shadow(color: .black.opacity(0.1), radius: 8)
        .sheet(isPresented: $vm.isShowingSizePicker) {
            sizePickerSheet
        }
        .sheet(isPresented: $vm.isShowingColorPicker) {
            colorPickerSheet
        }
        .appBackground()
        .unavailableFeatureAlert(isPresented: $vm.isShowingUnavailableAlert)
        .addedToCartAlert(isPresented: $vm.isShowingAddToCartAlert)
    }
    
    
    private var imageSection: some View {
        VStack(spacing: 0) {
            
            
            ZStack(alignment: .bottom) {
                Ellipse()
                    .fill(Color.black.opacity(0.45))
                    .frame(width: 100, height: 6)
                    .blur(radius: 6)
                    .padding(.bottom, 22)
                    .allowsHitTesting(false)
                
                KFImage(URL(string: vm.product.imageURL1))
                    .placeholder {
                        ProgressView()
                    }
                    .onFailure { _ in }
                    .fade(duration: 0.25)
                    .resizable()
                    .scaledToFit()
            }
            .frame(width: 130, height: 130)
        }
    }
    
    private var infoSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            titleRow
            sizeAndColorRow
            priceRow
            actionButtons
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var titleRow: some View {
        HStack {
            Text(vm.product.name)
                .font(.subheadline)
                .fontWeight(.bold)
            
            Text(vm.product.type.rawValue)
                .font(.caption)
                .foregroundStyle(Color.textMuted)
            
            Spacer()
            
            FavoriteButtonView(isFavorite: true, size: 28, showsShadow: false) {
                onRemoveFavorite()
            }
        }
    }
    
    private var priceRow: some View {
        HStack(spacing: 8) {
            Text(vm.product.price, format: .currency(code: "USD"))
                .font(.subheadline)
                .fontWeight(.bold)
            
            Text(vm.originalPrice, format: .currency(code: "USD"))
                .font(.caption)
                .foregroundStyle(Color.textMuted)
                .strikethrough()
        }
    }
    
    private var sizeAndColorRow: some View {
        HStack(spacing: 20) {
            sizeButton
            colorButton
        }
    }
    
    private var sizeButton: some View {
        Button {
            vm.isShowingSizePicker = true
        } label: {
            HStack(spacing: 4) {
                Text("Size:")
                    .foregroundStyle(Color.textMuted)
                Text("\(vm.selectedSize)")
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
            }
            .font(.caption)
        }
    }
    
    private var colorButton: some View {
        Button {
            vm.isShowingColorPicker = true
        } label: {
            HStack(spacing: 8) {
                Text("Color:")
                    .foregroundStyle(Color.textMuted)
                    .font(.caption)
                
                Circle()
                    .fill(vm.selectedProductColor?.displayColor ?? Color.backgroundSecondary)
                    .frame(width: 20, height: 20)
                    .overlay(
                        Circle()
                            .stroke(Color.borderDefault, lineWidth: 1)
                    )
            }
        }
    }
    
    private var actionButtons: some View {
        HStack(spacing: 8) {
            Button {
                vm.buyNowTapped()
            } label: {
                Text("Buy now")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            
            Button {
                cartManager.addToCart(
                    product: vm.product,
                    size: vm.selectedSize,
                    color: vm.selectedColor
                )
                vm.isShowingAddToCartAlert = true
            } label: {
                Text("Add to cart")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.borderDefault, lineWidth: 1.5)
                    )
            }
        }
    }
    
    
    private var sizePickerSheet: some View {
        VStack(spacing: 0) {
            Text("Choose size")
                .font(.headline)
                .padding(.top)
            
            Picker("Size", selection: $vm.selectedSize) {
                ForEach(vm.product.availableSizes, id: \.self) { size in
                    Text("\(size)").tag(size)
                }
            }
            .pickerStyle(.wheel)
            
            Button("Done") {
                vm.isShowingSizePicker = false
            }
            .padding(.bottom)
        }
        .presentationDetents([.height(300)])
    }
    
    private var colorPickerSheet: some View {
        VStack(spacing: 0) {
            Text("Choose color")
                .font(.headline)
                .padding(.top)
            
            Picker("Color", selection: $vm.selectedColor) {
                ForEach(vm.product.availableColors, id: \.self) { color in
                    Text(color.capitalized).tag(color)
                }
            }
            .pickerStyle(.wheel)
            
            Button("Done") {
                vm.isShowingColorPicker = false
            }
            .padding(.bottom)
        }
        .presentationDetents([.height(300)])
    }
}


#Preview {
    FavoriteCardView(
        product: Product(
            id: "speedcat_og",
            name: "Speedcat OG",
            type: .lifestyle,
            price: 159.99,
            description: "",
            imageURL1: "",
            imageURL2: "",
            availableSizes: [38, 40, 41, 43],
            availableColors: ["black", "red"]
        ),
        onRemoveFavorite: { }
    )
    .padding()
    .environment(CartManager())
}
