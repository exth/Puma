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


extension View {
    func closeConfirmationAlert(
        isPresented: Binding<Bool>,
        title: String,
        onConfirm: @escaping () -> Void
    ) -> some View {
        self.alert(title, isPresented: isPresented) {
            Button("Close", role: .destructive, action: onConfirm)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("If you close now, your progress will be lost and you'll need to start over.")
        }
    }
}
