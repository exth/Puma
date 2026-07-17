import Foundation


@Observable
final class CatalogViewModel {
    var products: [Product] = []
    var isLoading = false
    var errorMessage: String?
    
    var findModel = ""
    var selectedFilter: CatalogFilter = .all
    
    private let productService: ProductServiceProtocol
    private let cacheService: ProductCacheServiceProtocol
    
    private var hasStartedLoading = false
    
    init(
        productService: ProductServiceProtocol = FirebaseProductService(),
        cacheService: ProductCacheServiceProtocol = ProductCacheService.shared
    ) {
        self.productService = productService
        self.cacheService = cacheService
    }
    
    
    var filteredProducts: [Product] {
        let byType: [Product]
        switch selectedFilter {
        case .all:
            byType = products
        case .lifestyle:
            byType = products.filter {
                $0.type == .lifestyle
            }
        case .sport:
            byType = products.filter {
                $0.type == .sport
            }
        }
        
        let query = findModel.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else {
            return byType
        }
        
        return byType.filter {
            $0.name.localizedCaseInsensitiveContains(query)
        }
    }
    
    var hasNoSearchResults: Bool {
        !findModel.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && filteredProducts.isEmpty
    }
    
    
    func loadProducts() async {
        guard !hasStartedLoading else {
            return
        }
        hasStartedLoading = true
        
        if let cached = cacheService.loadCachedProducts(), !cached.isEmpty {
            products = cached
            isLoading = false
            await fetchFromNetwork(showSpinner: false, showErrorOnFailure: false)
        } else {
            await fetchFromNetwork(showSpinner: true, showErrorOnFailure: true)
        }
    }
    
    func refreshProducts() async {
        await fetchFromNetwork(showSpinner: false, showErrorOnFailure: products.isEmpty)
    }
    
    func retryLoading() async {
        errorMessage = nil
        await fetchFromNetwork(showSpinner: true, showErrorOnFailure: true)
    }
    
    
    private func fetchFromNetwork(showSpinner: Bool, showErrorOnFailure: Bool) async {
        if showSpinner {
            isLoading = true
        }
        
        do {
            let fetched = try await productService.fetchProducts()
            products = fetched
            errorMessage = nil
            cacheService.saveProducts(fetched)
        } catch {
            if showErrorOnFailure {
                errorMessage = "Unable to load catalog. Please check your internet connection"
            }
        }
        
        if showSpinner {
            isLoading = false
        }
    }
}
