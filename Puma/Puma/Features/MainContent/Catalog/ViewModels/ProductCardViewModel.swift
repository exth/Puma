import Foundation


@Observable
final class ProductCardViewModel {
    private let favoritesManager: FavoritesManager

    let product: Product
    
    init(product: Product, favoritesManager: FavoritesManager) {
        self.product = product
        self.favoritesManager = favoritesManager
    }
    
    
    var isFavorite: Bool {
        favoritesManager.isFavorite(product)
    }
    
    
    func toggleFavorite() {
        favoritesManager.toggleFavorite(product)
    }
}
