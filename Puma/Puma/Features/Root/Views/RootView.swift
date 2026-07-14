import SwiftUI


struct RootView: View {
    @Environment(SessionManager.self) private var session
    
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
                    AuthView(session: session)
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
