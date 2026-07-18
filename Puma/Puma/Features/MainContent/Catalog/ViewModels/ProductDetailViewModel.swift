import Foundation


@Observable
final class ProductDetailViewModel {
    let product: Product
    
    var selectedSize: Int?
    var selectedColor: ProductColor?
    var selectedImageIndex = 0
    var isShowingUnavailableAlert = false
    
    let allSizes = Array(36...46)
    let allColors = ProductColor.allCases
    
    init(product: Product) {
        self.product = product
    }
    
    
    var originalPrice: Double {
        product.price + 50
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
    
    func buyNowTapped() {
        isShowingUnavailableAlert = true
    }
}
