import SwiftUI


struct ProfileView: View {
    @State private var vm: ProfileViewModel

    init(session: SessionManager) {
        _vm = State(initialValue: ProfileViewModel(session: session))
    }
    
    
    var body: some View {
        Text("ProfileView")
        
        Button {
            vm.logOut()
        } label: {
            Text("Log Out")
        }
    }
}


#Preview {
    ProfileView(session: SessionManager())
}
