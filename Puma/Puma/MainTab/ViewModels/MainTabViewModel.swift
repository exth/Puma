import Foundation


enum TabItem {
    case info
    case catalog
    case cart
    case profile
}


@Observable
final class MainTabViewModel {
    var selectedTab: TabItem
    
    init(startTab: TabItem) {
        self.selectedTab = startTab
    }
}
