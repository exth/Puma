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
            Text("If you close now, your progress will be lost and you'll need to start over")
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
            Text("Purchases aren't available in the app just yet. Please visit the official PUMA website - you'll find the link in the Profile tab")
        }
    }
}


extension View {
    func addedToCartAlert(isPresented: Binding<Bool>) -> some View {
        self.alert("Added to Cart", isPresented: isPresented) {
            Button("Continue", role: .cancel) { }
        } message: {
            Text("The item has been added to your cart")
        }
    }
}


extension View {
    func signOutAlert(isPresented: Binding<Bool>, onConfirm: @escaping () -> Void) -> some View {
        self.alert("Sign Out", isPresented: isPresented) {
            Button("Sign Out", role: .destructive, action: onConfirm)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you want to sign out? You can always sign back in anytime")
        }
    }
}


extension View {
    func deleteAccountAlert(isPresented: Binding<Bool>, onConfirm: @escaping () -> Void) -> some View {
        self.alert("Delete Account", isPresented: isPresented) {
            Button("Delete Account", role: .destructive, action: onConfirm)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you want to delete your account? All your data, including favorites and cart items, will be permanently removed")
        }
    }
}


extension View {
    func finalDeleteAccountAlert(isPresented: Binding<Bool>, onConfirm: @escaping () -> Void) -> some View {
        self.alert("This Can't Be Undone", isPresented: isPresented) {
            Button("Delete Permanently", role: .destructive, action: onConfirm)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Once deleted, your account cannot be restored. This action is permanent and irreversible")
        }
    }
}
