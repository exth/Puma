import Foundation


@Observable
final class FavoriteCardViewModel: UnavailablePurchasable {
    private let cartManager: CartManager
    
    let product: Product
    
    var selectedSize: Int
    var selectedColor: String
    
    var isShowingSizePicker = false
    var isShowingColorPicker = false
    var isShowingUnavailableAlert = false
    var isShowingAddToCartAlert = false
    
    init(product: Product, cartManager: CartManager) {
        self.product = product
        self.cartManager = cartManager
        self.selectedSize = product.availableSizes.min() ?? 0
        self.selectedColor = product.availableColors.first ?? ""
    }
    
    
    var selectedProductColor: ProductColor? {
        ProductColor(rawValue: selectedColor)
    }
    

    func addToCart() {
        cartManager.addToCart(product: product, size: selectedSize, color: selectedColor)
        isShowingAddToCartAlert = true
    }
}
