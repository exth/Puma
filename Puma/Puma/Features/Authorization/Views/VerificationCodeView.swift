import SwiftUI


struct VerificationCodeView: View {
    @State private var vm: VerificationCodeViewModel

    let coordinator: AuthFlowCoordinator
    
    
    init(coordinator: AuthFlowCoordinator, email: String) {
        self.coordinator = coordinator
        _vm = State(initialValue: VerificationCodeViewModel(email: email))
    }
        
    var body: some View {
        VStack {
            Text("VerificationCodeView")
                        
            Text("Мы отправили ссылку для входа на \(vm.email). Пожалуйста, ерейдите по ней")
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    coordinator.close()
                } label: {
                    Image(systemName: "xmark")
                }
            }
        }
        .appBackground()
    }
}


#Preview {
    NavigationStack {
        VerificationCodeView(coordinator: AuthFlowCoordinator(), email: "sss@gmail.com")
    }
}


