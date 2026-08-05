import SwiftUI


struct CartView: View {
    @State private var vm: CartViewModel
    
    let onShowCatalog: () -> Void
    
    init(cartManager: CartManager, onShowCatalog: @escaping () -> Void) {
        _vm = State(initialValue: CartViewModel(cartManager: cartManager))
        self.onShowCatalog = onShowCatalog
    }
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                if vm.hasItems {
                    PumaWatermarkView(fontSize: 85)
                        .transition(.opacity)
                }
                
                Group {
                    if vm.hasItems {
                        cartList
                    } else {
                        emptyCartSection
                    }
                }
                .transition(.opacity)
            }
            .animation(.easeInOut(duration: 0.3), value: vm.hasItems)
            .appBackground()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("My Cart")
                        .font(.headline)
                }
            }
        }
    }
    
    
    private var cartList: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(vm.cartItems) { item in
                    CartCardView(item: item) {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            vm.removeFromCart(item)
                        }
                    }
                    .transition(.opacity.combined(with: .move(edge: .top)))
                }
            }
            .padding()
        }
        .scrollIndicators(.hidden)
    }
    
    private var emptyCartSection: some View {
        VStack(spacing: 16) {
            ContentUnavailableView(
                "Your Cart is Empty",
                systemImage: "tray",
                description:
                    Text("Looks like you haven't added anything yet. Browse catalog to find something you'll like")
                    .font(.subheadline)
            )
            
            CatalogButton(title: "Show catalog", direction: .leading, action: onShowCatalog)
                .padding(.top, 4)
            
            Spacer()
        }
        .padding(.horizontal, 32)
    }
}


#Preview {
    CartView(cartManager: CartManager(), onShowCatalog: { })
}
