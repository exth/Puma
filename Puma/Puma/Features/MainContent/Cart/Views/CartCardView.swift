import SwiftUI
import Kingfisher


struct CartCardView: View {
    @State private var vm: CartCardViewModel
    let onRemove: () -> Void
    
    init(item: CartItem, onRemove: @escaping () -> Void) {
        _vm = State(initialValue: CartCardViewModel(item: item))
        self.onRemove = onRemove
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
        .unavailableFeatureAlert(isPresented: $vm.isShowingUnavailableAlert)
    }
    
    
    private var imageSection: some View {
        ZStack(alignment: .bottom) {
            Ellipse()
                .fill(Color.black.opacity(0.45))
                .frame(width: 100, height: 6)
                .blur(radius: 6)
                .padding(.bottom, 22)
                .allowsHitTesting(false)
            
            KFImage(URL(string: vm.item.product.imageURL1))
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
    
    private var infoSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            titleRow
            sizeAndColorRow
            priceRow
            buyNowButton
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var titleRow: some View {
        HStack {
            Text(vm.item.product.name)
                .font(.subheadline)
                .fontWeight(.bold)
            
            Text(vm.item.product.type.rawValue)
                .font(.caption)
                .foregroundStyle(Color.textMuted)
            
            Spacer()
            
            trashButton
        }
    }
    
    private var trashButton: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                onRemove()
            }
        } label: {
            Image(systemName: "trash")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.black.opacity(0.6))
                .frame(width: 28, height: 28)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.15), radius: 3)
        }
    }
    
    private var sizeAndColorRow: some View {
        HStack(spacing: 20) {
            HStack(spacing: 4) {
                Text("Size:")
                    .foregroundStyle(Color.textMuted)
                Text("\(vm.item.selectedSize)")
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
            }
            .font(.caption)
            
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
    
    private var priceRow: some View {
        HStack(spacing: 8) {
            Text(vm.item.product.price, format: .currency(code: "USD"))
                .font(.subheadline)
                .fontWeight(.bold)
            
            Text(vm.originalPrice, format: .currency(code: "USD"))
                .font(.caption)
                .foregroundStyle(Color.textMuted)
                .strikethrough()
        }
    }
    
    private var buyNowButton: some View {
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
    }
}


#Preview {
    CartCardView(
        item: CartItem(
            id: UUID().uuidString,
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
            selectedSize: 41,
            selectedColor: "black"
        ),
        onRemove: { }
    )
    .padding()
}
