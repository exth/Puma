import XCTest
@testable import Puma


final class CartCardViewModelTests: XCTestCase {
    var vm: CartCardViewModel!
    
    override func setUp() {
        super.setUp()
        let item = CartItem(
            id: "1",
            product: Product(
                id: "1", name: "Speedcat OG", type: .lifestyle, price: 100,
                description: "", imageURL1: "", imageURL2: "",
                availableSizes: [40], availableColors: ["black"]
            ),
            selectedSize: 40,
            selectedColor: "black"
        )
        vm = CartCardViewModel(item: item)
    }
    
    override func tearDown() {
        vm = nil
        super.tearDown()
    }
    
    
    func test_originalPrice_shouldBePricePlusFifty() {
        XCTAssertEqual(vm.originalPrice, 150)
    }
    
    func test_buyNowTapped_shouldShowUnavailableAlert() {
        vm.buyNowTapped()
        XCTAssertTrue(vm.isShowingUnavailableAlert)
    }
}
