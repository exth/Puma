import XCTest
@testable import Puma


final class CartManagerTests: XCTestCase {
    var cartManager: CartManager!
    
    private let testProduct = Product(
        id: "1", name: "Speedcat OG", type: .lifestyle, price: 100,
        description: "", imageURL1: "", imageURL2: "",
        availableSizes: [40], availableColors: ["black"]
    )
    
    override func setUp() {
        super.setUp()
        UserDefaults.standard.removeObject(forKey: "cartItems")
        cartManager = CartManager()
    }
    
    override func tearDown() {
        cartManager = nil
        UserDefaults.standard.removeObject(forKey: "cartItems")
        super.tearDown()
    }
    
    
    func test_addToCart_shouldInsertItem() {
        cartManager.addToCart(product: testProduct, size: 40, color: "black")
        XCTAssertEqual(cartManager.cartItems.count, 1)
    }
    
    func test_removeFromCart_shouldRemoveItem() {
        cartManager.addToCart(product: testProduct, size: 40, color: "black")
        let item = cartManager.cartItems[0]
        
        cartManager.removeFromCart(item)
        
        XCTAssertTrue(cartManager.cartItems.isEmpty)
    }
}
