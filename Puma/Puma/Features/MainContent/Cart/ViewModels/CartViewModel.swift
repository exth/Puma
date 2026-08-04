import Foundation


@Observable
final class CartViewModel {
    private let cartManager: CartManager
    
    init(cartManager: CartManager) {
        self.cartManager = cartManager
    }
    
    
    var cartItems: [CartItem] {
        cartManager.cartItems
    }
    
    var hasItems: Bool {
        !cartItems.isEmpty
    }
    
    
    func removeFromCart(_ item: CartItem) {
        cartManager.removeFromCart(item)
    }
}
