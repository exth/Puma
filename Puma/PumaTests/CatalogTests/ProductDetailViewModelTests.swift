import XCTest
@testable import Puma


final class ProductDetailViewModelTests: XCTestCase {
    var vm: ProductDetailViewModel!
    
    override func setUp() {
        super.setUp()
        let product = Product(
            id: "1", name: "Speedcat OG", type: .lifestyle, price: 100,
            description: "", imageURL1: "", imageURL2: "",
            availableSizes: [40], availableColors: ["black"]
        )
        vm = ProductDetailViewModel(product: product)
    }
    
    override func tearDown() {
        vm = nil
        super.tearDown()
    }
    
    
    func test_selectSize_availableSize_shouldSetSelectedSize() {
        vm.selectSize(40)
        XCTAssertEqual(vm.selectedSize, 40)
    }
    
    func test_selectSize_unavailableSize_shouldNotSetSelectedSize() {
        vm.selectSize(38)
        XCTAssertNil(vm.selectedSize)
    }
    
    func test_canPurchase_sizeAndColorSelected_shouldBeTrue() {
        vm.selectSize(40)
        vm.selectColor(.black)
        XCTAssertTrue(vm.canPurchase)
    }
    
    func test_canPurchase_onlySizeSelected_shouldBeFalse() {
        vm.selectSize(40)
        XCTAssertFalse(vm.canPurchase)
    }
}
