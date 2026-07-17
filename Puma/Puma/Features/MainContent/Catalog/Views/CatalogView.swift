import SwiftUI

struct CatalogView: View {
    @State private var vm = CatalogViewModel()
    @State private var coordinator = CatalogFlowCoordinator()
    @Namespace private var animation
    @FocusState private var isSearchFocused: Bool
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            ScrollView {
                VStack(spacing: 15) {
                    headerSection
                    searchField
                    filterSection
                    contentSection
                }
                .padding()
                .contentShape(Rectangle())
                .onTapGesture {
                    isSearchFocused = false
                }
                .navigationDestination(for: CatalogScreens.self) { screen in
                    switch screen {
                    case .productDetail(let product):
                        ProductDetailView(product: product)
                    case .favorite:
                        FavoriteView()
                    }
                }
            }
            .scrollDismissesKeyboard(.interactively)
            .refreshable {
                await vm.refreshProducts()
            }
            .task {
                await vm.loadProducts()
            }
        }
    }
    
    
    private var headerSection: some View {
        HStack(spacing: 0) {
            Text("Move With Puma")
                .font(.system(size: 25)).bold()
            
            Spacer()
            
            Button {
                coordinator.showFavorite()
            } label: {
                Image(systemName: "heart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
                    .foregroundStyle(Color.pumaColor)
                    .shadow(color: .pumaColor.opacity(0.6), radius: 5)
            }
        }
    }
    
    private var searchField: some View {
        ZStack(alignment: .trailing) {
            TextField("Find Model", text: $vm.findModel)
                .focused($isSearchFocused)
                .padding(12)
                .padding(.trailing, 32)
                .autocorrectionDisabled()
                .frame(maxWidth: .infinity)
                .background(Color.backgroundPrimary)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay (
                     RoundedRectangle(cornerRadius: 16)
                          .stroke(Color.borderDefault, lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.15), radius: 5)
            
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color.textSecondary)
                .shadow(color: .textSecondary.opacity(0.5), radius: 8)
                .padding(.trailing, 12)
                .contentShape(Rectangle())
                .highPriorityGesture(
                    TapGesture().onEnded {
                        isSearchFocused.toggle()
                    }
                )
        }
    }
    
    private var filterSection: some View {
        HStack(spacing: 6) {
            ForEach(CatalogFilter.allCases, id: \.self) { filter in
                FilterChipView(
                    filter: filter,
                    isSelected: vm.selectedFilter == filter,
                    namespace: animation
                ) {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                        vm.selectedFilter = filter
                    }
                }
            }
        }
        .padding(5)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.cardBackground.opacity(0.3))
        )
    }
    
    @ViewBuilder
    private var contentSection: some View {
        if vm.isLoading {
            ProgressView()
                .frame(maxWidth: .infinity)
                .padding(.top, 80)
        } else if let errorMessage = vm.errorMessage {
            errorSection(errorMessage)
        } else if vm.hasNoSearchResults {
            noResultsSection
        } else {
            productsGrid
        }
    }
    
    private var productsGrid: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(vm.filteredProducts) { product in
                Button {
                    coordinator.showProductDetail(product)
                } label: {
                    ProductCardView(product: product)
                }
                .buttonStyle(.plain)
            }
        }
    }
    
    private var noResultsSection: some View {
        VStack(spacing: 16) {
            Image(systemName: "text.magnifyingglass")
                .font(.system(size: 30, weight: .semibold))
                .foregroundStyle(Color.pumaColor)
                .frame(width: 84, height: 84)
                .background(
                    Circle()
                        .fill(Color.backgroundSecondary.opacity(0.6))
                )
            
            VStack(spacing: 6) {
                Text("No models found")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text("We couldn't find anything. Try another name")
                    .font(.subheadline)
                    .foregroundStyle(Color.textMuted)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 60)
        .padding(.bottom, 40)
    }
    
    private func errorSection(_ message: String) -> some View {
        VStack(spacing: 12) {
            Text(message)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            
            Button("Retry") {
                Task {
                    await vm.retryLoading()
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 60)
    }
}


#Preview {
    CatalogView()
}
