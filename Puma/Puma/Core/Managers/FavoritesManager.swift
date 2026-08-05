import Foundation


@Observable
final class FavoritesManager {
    private(set) var favoriteProducts: [Product] = []
    
    private let storageKey = "favoriteProducts"
    
    init() {
        loadFavorites()
    }
    
    
    func isFavorite(_ product: Product) -> Bool {
        favoriteProducts.contains(product)
    }
    
    func toggleFavorite(_ product: Product) {
        if let index = favoriteProducts.firstIndex(of: product) {
            favoriteProducts.remove(at: index)
        } else {
            favoriteProducts.append(product)
        }
        saveFavorites()
    }
    
    func removeFavorite(_ product: Product) {
        favoriteProducts.removeAll {
            $0.id == product.id
        }
        saveFavorites()
    }
    
    private func loadFavorites() {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let products = try? JSONDecoder().decode([Product].self, from: data)
        else {
            return
        }
        
        favoriteProducts = products
    }
    
    private func saveFavorites() {
        guard let data = try? JSONEncoder().encode(favoriteProducts) else {
            return
        }
        
        UserDefaults.standard.set(data, forKey: storageKey)
    }
}
