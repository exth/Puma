import SwiftUI


struct RootView: View {
    @Environment(SessionManager.self) private var session
    @Environment(FirebaseAuthService.self) private var authService
    
    
    var body: some View {
        ZStack {
            Color.backgroundPrimary
                .ignoresSafeArea()
            
            Group {
                switch session.authState {
                case .firstLogin:
                    MainTabView(startTab: .info)
                case .loggedIn:
                    MainTabView(startTab: .catalog)
                case .loggedOut:
                    AuthView(session: session, authService: authService)
                }
            }
            .transition(.opacity)

        }
    }
}


#Preview {
    RootView()
        .environment(SessionManager())
}
