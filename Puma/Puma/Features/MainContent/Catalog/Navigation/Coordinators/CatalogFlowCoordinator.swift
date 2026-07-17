import SwiftUI


@Observable
final class CatalogFlowCoordinator {
    var path = NavigationPath()
    
    
    func showProductDetail(_ product: Product) {
        path.append(CatalogScreens.productDetail(product: product))
    }
    
    func showFavorite() {
        path.append(CatalogScreens.favorite)
    }
    
    func goBack() {
        path.removeLast()
    }
}
