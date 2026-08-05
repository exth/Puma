import XCTest
@testable import Puma


@MainActor
final class CatalogViewModelTests: XCTestCase {
    var vm: CatalogViewModel!
    var mockProductService: MockProductService!
    
    private let testProduct1 = Product(
        id: "1", name: "Speedcat OG", type: .lifestyle, price: 100,
        description: "", imageURL1: "", imageURL2: "",
        availableSizes: [40], availableColors: ["black"]
    )
    private let testProduct2 = Product(
        id: "2", name: "RS-X", type: .sport, price: 150,
        description: "", imageURL1: "", imageURL2: "",
        availableSizes: [41], availableColors: ["white"]
    )
    
    override func setUp() {
        super.setUp()
        mockProductService = MockProductService()
        vm = CatalogViewModel(productService: mockProductService, cacheService: MockProductCacheService())
    }
    
    override func tearDown() {
        vm = nil
        mockProductService = nil
        super.tearDown()
    }
    
    
    func test_loadProducts_success_shouldSetProducts() async {
        mockProductService.productsToReturn = [testProduct1, testProduct2]
        await vm.loadProducts()
        
        XCTAssertEqual(vm.products.count, 2)
    }
    
    func test_filteredProducts_bySelectedFilter_shouldReturnMatchingType() async {
        mockProductService.productsToReturn = [testProduct1, testProduct2]
        await vm.loadProducts()
        
        vm.selectedFilter = .sport
        
        XCTAssertEqual(vm.filteredProducts, [testProduct2])
    }
    
    func test_hasNoSearchResults_noMatches_shouldBeTrue() async {
        mockProductService.productsToReturn = [testProduct1]
        await vm.loadProducts()
        
        vm.findModel = "nonexistent"
        
        XCTAssertTrue(vm.hasNoSearchResults)
    }
}
