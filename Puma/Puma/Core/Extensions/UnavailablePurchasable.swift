import Foundation


protocol UnavailablePurchasable: AnyObject {
    var isShowingUnavailableAlert: Bool { get set }
    func buyNowTapped()
}


extension UnavailablePurchasable {
    func buyNowTapped() {
        isShowingUnavailableAlert = true
    }
}
