import Foundation


@Observable
final class FavoriteCardViewModel {
    let product: Product
    
    var selectedSize: Int
    var selectedColor: String
    
    var isShowingSizePicker = false
    var isShowingColorPicker = false
    var isShowingUnavailableAlert = false
    
    init(product: Product) {
        self.product = product
        self.selectedSize = product.availableSizes.min() ?? 0
        self.selectedColor = product.availableColors.first ?? ""
    }
    
    
    var selectedProductColor: ProductColor? {
        ProductColor(rawValue: selectedColor)
    }
    
    var originalPrice: Double {
        product.price + 50
    }
    
    
    func buyNowTapped() {
        isShowingUnavailableAlert = true
    }
}
