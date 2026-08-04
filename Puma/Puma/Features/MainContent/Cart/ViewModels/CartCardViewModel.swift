import Foundation


@Observable
final class CartCardViewModel {
    let item: CartItem
    
    var isShowingUnavailableAlert = false
    
    init(item: CartItem) {
        self.item = item
    }
    
    
    var selectedProductColor: ProductColor? {
        ProductColor(rawValue: item.selectedColor)
    }
    
    var originalPrice: Double {
        item.product.price + 50
    }
    
    
    func buyNowTapped() {
        isShowingUnavailableAlert = true
    }
}
