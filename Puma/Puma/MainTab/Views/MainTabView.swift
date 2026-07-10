import SwiftUI

// 6) сделать нужный порядок
struct MainTabView: View {
    @Environment(SessionManager.self) private var session
    
    @State private var vm: MainTabViewModel
    
    // 5) что за оно и зачем
    init(startTab: TabItem) {
        _vm = State(initialValue: MainTabViewModel(startTab: startTab))
    }
    
    
    var body: some View {
        // 7) что за оно и почему внутри body?
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
                ProfileView()
            }
        }
        // 8) что это и зачем
        .onAppear {
            if vm.selectedTab == .info {
                session.infoSeen()
            }
        }
    }
}


#Preview {
    MainTabView(startTab: .info)
        .environment(SessionManager())
}
