import SwiftUI


struct RootView: View {
    @Environment(SessionManager.self) private var session
    
    var body: some View {
        ZStack {
            Color.backgroundPrimary
                .ignoresSafeArea()
            
            switch session.authState {
            case .firstLogin:
                MainTabView(startTab: .info)
            case .loggedIn:
                MainTabView(startTab: .catalog)
            case .loggedOut:
                AuthView(session: session)
            }
        }
    }
}


#Preview {
    RootView()
        .environment(SessionManager())
}
