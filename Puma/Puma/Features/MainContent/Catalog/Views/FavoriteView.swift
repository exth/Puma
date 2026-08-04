import SwiftUI


struct FavoriteView: View {
    @State private var vm: FavoriteViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(favoritesManager: FavoritesManager) {
        _vm = State(initialValue: FavoriteViewModel(favoritesManager: favoritesManager))
    }
    
    
    var body: some View {
        ZStack {
            if vm.hasFavorites {
                PumaWatermarkView(fontSize: 75)
                    .transition(.opacity)
            }
            
            Group {
                if vm.hasFavorites {
                    favoritesList
                } else {
                    ContentUnavailableView(
                        "No Favorites Yet",
                        systemImage: "heart.slash",
                        description:
                            Text("Browse the catalog and tap the heart icon on a product card to save items you like")
                            .font(.subheadline)
                    )
                }
            }
            .transition(.opacity)
        }
        .animation(.easeInOut(duration: 0.3), value: vm.hasFavorites)
        .appBackground()
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("My Favorite")
                    .font(.headline)
            }
        }
    }
    
    
    private var favoritesList: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(vm.favoriteProducts) { product in
                    FavoriteCardView(product: product) {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            vm.removeFavorite(product)
                        }
                    }
                    .transition(.opacity.combined(with: .move(edge: .top)))
                }
            }
            .padding()
        }
        .scrollIndicators(.hidden)
    }
}


#Preview {
    NavigationStack {
        FavoriteView(favoritesManager: FavoritesManager())
    }
}
