import SwiftUI


struct AuthView: View {
    @State private var vm: AuthViewModel
    
    init(session: SessionManager) {
        _vm = State(initialValue: AuthViewModel(session: session))
    }
    
    var body: some View {
        @Bindable var vm = vm
        
        // 11) MARK: -Перенести это на следующий View-экран и разбить (тк на одном View чисто почта, а на втором - пароль)-
        VStack {
            TextField("Email", text: $vm.email)
            SecureField("Password", text: $vm.password)
            Button {
                vm.login()
            } label: {
                Text("Continue")
            }
        }
        .background(Color.black.opacity(0.5))
    }
}

#Preview {
    AuthView(session: SessionManager())
}
