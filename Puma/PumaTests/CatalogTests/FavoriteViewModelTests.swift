import XCTest
@testable import Puma


final class FavoriteViewModelTests: XCTestCase {
    var vm: FavoriteViewModel!
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
        vm = FavoriteViewModel(favoritesManager: favoritesManager)
    }
    
    override func tearDown() {
        vm = nil
        favoritesManager = nil
        UserDefaults.standard.removeObject(forKey: "favoriteProducts")
        super.tearDown()
    }
    
    
    func test_hasFavorites_withProduct_shouldBeTrue() {
        favoritesManager.toggleFavorite(testProduct)
        XCTAssertTrue(vm.hasFavorites)
    }
    
    func test_removeFavorite_shouldRemoveFromList() {
        favoritesManager.toggleFavorite(testProduct)
        vm.removeFavorite(testProduct)
        
        XCTAssertFalse(vm.hasFavorites)
    }
}
