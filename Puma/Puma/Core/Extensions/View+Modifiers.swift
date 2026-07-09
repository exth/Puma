import SwiftUI


extension View {
    func applyAppBakground() -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.backgroundPrimary)
            .ignoresSafeArea()
    }
}
