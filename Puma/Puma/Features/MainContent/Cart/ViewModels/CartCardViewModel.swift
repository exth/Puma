import Foundation


@Observable
final class CartCardViewModel: UnavailablePurchasable {
    let item: CartItem
    
    var isShowingUnavailableAlert = false
    
    init(item: CartItem) {
        self.item = item
    }
    
    
    var selectedProductColor: ProductColor? {
        ProductColor(rawValue: item.selectedColor)
    }
}
