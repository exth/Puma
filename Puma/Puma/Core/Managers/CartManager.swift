import Foundation


@Observable
final class CartManager {
    private(set) var cartItems: [CartItem] = []
    
    private let storageKey = "cartItems"
    
    init() {
        loadCart()
    }
    
    
    func addToCart(product: Product, size: Int, color: String) {
        let item = CartItem(id: UUID().uuidString, product: product, selectedSize: size, selectedColor: color)
        cartItems.insert(item, at: 0)
        saveCart()
    }
    
    func removeFromCart(_ item: CartItem) {
        cartItems.removeAll {
            $0.id == item.id
        }
        saveCart()
    }
    
    
    private func loadCart() {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let items = try? JSONDecoder().decode([CartItem].self, from: data)
        else {
            return
        }
        
        cartItems = items
    }
    
    private func saveCart() {
        guard let data = try? JSONEncoder().encode(cartItems) else {
            return
        }
        
        UserDefaults.standard.set(data, forKey: storageKey)
    }
}
