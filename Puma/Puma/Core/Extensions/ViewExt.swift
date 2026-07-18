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
    func closeConfirmationAlert(isPresented: Binding<Bool>, title: String, onConfirm: @escaping () -> Void) -> some View {
        self.alert(title, isPresented: isPresented) {
            Button("Close", role: .destructive, action: onConfirm)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("If you close now, your progress will be lost and you'll need to start over.")
        }
    }
}


extension View {
    func cardStyle() -> some View {
        self
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black.opacity(0.3), lineWidth: 2)
                    .blur(radius: 4)
            )
    }
}


extension View {
    func unavailableFeatureAlert(isPresented: Binding<Bool>) -> some View {
        self.alert("Coming Soon", isPresented: isPresented) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Purchases aren't available in the app just yet. Please visit the official PUMA website — you'll find the link in the Profile tab.")
        }
    }
}
