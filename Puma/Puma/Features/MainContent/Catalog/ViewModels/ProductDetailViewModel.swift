import Foundation


@Observable
final class ProductDetailViewModel: UnavailablePurchasable {
    private let cartManager: CartManager
    
    let product: Product
    
    var selectedSize: Int?
    var selectedColor: ProductColor?
    var selectedImageIndex = 0
    var isShowingUnavailableAlert = false
    var isShowingAddToCartAlert = false
    
    let allSizes = Array(36...46)
    let allColors = ProductColor.allCases
    
    init(product: Product, cartManager: CartManager) {
        self.product = product
        self.cartManager = cartManager
    }
    
    
    var canPurchase: Bool {
        selectedSize != nil && selectedColor != nil
    }
    
    
    func isSizeAvailable(_ size: Int) -> Bool {
        product.availableSizes.contains(size)
    }
    
    func isColorAvailable(_ color: ProductColor) -> Bool {
        product.availableColors.contains(color.rawValue)
    }
    
    func selectSize(_ size: Int) {
        guard isSizeAvailable(size) else {
            return
        }
        selectedSize = size
    }
    
    func selectColor(_ color: ProductColor) {
        guard isColorAvailable(color) else {
            return
        }
        selectedColor = color
    }
    
    func addToCart() {
        guard let size = selectedSize, let color = selectedColor else {
            return
        }
        cartManager.addToCart(product: product, size: size, color: color.rawValue)
        isShowingAddToCartAlert = true
    }
}
