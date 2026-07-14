import SwiftUI


struct AuthFlowContainerView: View {
    @State private var coordinator = AuthFlowCoordinator()
    @Environment(SessionManager.self) private var session
    @Environment(\.dismiss) private var dismissSheet
    
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            EmailInputView(coordinator: coordinator)
                .navigationDestination(for: AuthScreens.self) { screen in
                    switch screen {
                    case .passwordView(let email):
                        PasswordInputView(coordinator: coordinator, email: email)
                    case .signInView(let email):
                        SignInView(coordinator: coordinator, email: email, session: session)
                    case .verificationCodeView(let email):
                        VerificationCodeView(coordinator: coordinator, email: email)
                    }
                }
        }
        .background(Color.backgroundPrimary)
        .onAppear {
            coordinator.onClose = {
                dismissSheet()
            }
        }
    }
}


#Preview {
    AuthFlowContainerView()
        .environment(SessionManager())
}
