//
//  RootView.swift
//  Puma
//
//  Created by Вадим on 09.07.2026.
//

import SwiftUI

struct RootView: View {
    @Environment(SessionManager.self) private var session
    
    var body: some View {
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

#Preview {
    RootView()
}
