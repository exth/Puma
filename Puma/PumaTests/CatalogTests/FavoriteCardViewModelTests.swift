import XCTest
@testable import Puma


@MainActor
final class FavoriteCardViewModelTests: XCTestCase {
    var vm: FavoriteCardViewModel!
    
    override func setUp() {
        super.setUp()
        let product = Product(
            id: "1", name: "Speedcat OG", type: .lifestyle, price: 100,
            description: "", imageURL1: "", imageURL2: "",
            availableSizes: [40, 41], availableColors: ["black", "red"]
        )
        vm = FavoriteCardViewModel(product: product, cartManager: CartManager())
    }
    
    override func tearDown() {
        vm = nil
        super.tearDown()
    }
    
    
    func test_init_shouldSetDefaultSizeAndColorFromProduct() {
        XCTAssertEqual(vm.selectedSize, 40)
        XCTAssertEqual(vm.selectedColor, "black")
    }
    
    func test_buyNowTapped_shouldShowUnavailableAlert() {
        vm.buyNowTapped()
        XCTAssertTrue(vm.isShowingUnavailableAlert)
    }
}
