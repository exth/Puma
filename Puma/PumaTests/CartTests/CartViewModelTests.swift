import XCTest
@testable import Puma


final class CartViewModelTests: XCTestCase {
    var vm: CartViewModel!
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
        vm = CartViewModel(cartManager: cartManager)
    }
    
    override func tearDown() {
        vm = nil
        cartManager = nil
        UserDefaults.standard.removeObject(forKey: "cartItems")
        super.tearDown()
    }
    
    
    func test_hasItems_withItem_shouldBeTrue() {
        cartManager.addToCart(product: testProduct, size: 40, color: "black")
        XCTAssertTrue(vm.hasItems)
    }
    
    func test_removeFromCart_shouldRemoveItem() {
        cartManager.addToCart(product: testProduct, size: 40, color: "black")
        let item = vm.cartItems[0]
        
        vm.removeFromCart(item)
        
        XCTAssertFalse(vm.hasItems)
    }
}
