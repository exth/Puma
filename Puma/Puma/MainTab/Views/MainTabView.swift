import SwiftUI


struct MainTabView: View {
    @Environment(SessionManager.self) private var session
    
    @State private var vm: MainTabViewModel
    
    init(startTab: TabItem) {
        _vm = State(initialValue: MainTabViewModel(startTab: startTab))
    }
    
    
    var body: some View {
        @Bindable var vm = vm

        TabView(selection: $vm.selectedTab) {
            Tab("Info", systemImage: "info.circle.fill", value: TabItem.info) {
                InfoView()
            }
            
            Tab("Catalog", systemImage: "bag.fill", value: TabItem.catalog) {
                CatalogView()
            }
            
            Tab("Cart", systemImage: "cart.fill", value: TabItem.cart) {
                CartView()
            }
            
            Tab("Profile", systemImage: "person.circle.fill", value: TabItem.profile) {
                ProfileView(session: session)
            }
        }
    }
}


#Preview {
    MainTabView(startTab: .info)
        .environment(SessionManager())
}
