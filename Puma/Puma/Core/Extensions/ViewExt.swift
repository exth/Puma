import SwiftUI


extension View {
    func appBackground() -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.backgroundPrimary
                    .ignoresSafeArea())
    }
}
