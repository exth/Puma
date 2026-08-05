import XCTest
@testable import Puma


final class FavoritesManagerTests: XCTestCase {
    var favoritesManager: FavoritesManager!
    
    private let testProduct = Product(
        id: "1", name: "Speedcat OG", type: .lifestyle, price: 100,
        description: "", imageURL1: "", imageURL2: "",
        availableSizes: [40], availableColors: ["black"]
    )
    
    override func setUp() {
        super.setUp()
        UserDefaults.standard.removeObject(forKey: "favoriteProducts")
        favoritesManager = FavoritesManager()
    }
    
    override func tearDown() {
        favoritesManager = nil
        UserDefaults.standard.removeObject(forKey: "favoriteProducts")
        super.tearDown()
    }
    
    
    func test_toggleFavorite_shouldAddProduct() {
        favoritesManager.toggleFavorite(testProduct)
        XCTAssertTrue(favoritesManager.isFavorite(testProduct))
    }
    
    func test_toggleFavorite_calledTwice_shouldRemoveProduct() {
        favoritesManager.toggleFavorite(testProduct)
        favoritesManager.toggleFavorite(testProduct)
        
        XCTAssertFalse(favoritesManager.isFavorite(testProduct))
    }
}
