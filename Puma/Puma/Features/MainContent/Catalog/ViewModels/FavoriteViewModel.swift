import Foundation


@Observable
final class FavoriteViewModel {
    private let favoritesManager: FavoritesManager
    
    init(favoritesManager: FavoritesManager) {
        self.favoritesManager = favoritesManager
    }
    
    
    var favoriteProducts: [Product] {
        favoritesManager.favoriteProducts
    }
    
    var hasFavorites: Bool {
        !favoriteProducts.isEmpty
    }
    
    
    func removeFavorite(_ product: Product) {
        favoritesManager.removeFavorite(product)
    }
}
