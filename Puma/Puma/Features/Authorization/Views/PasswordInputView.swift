import SwiftUI


struct PasswordInputView: View {
    let coordinator: AuthFlowCoordinator
    
    @State private var vm: PasswordInputViewModel
    
    @FocusState private var isPasswordFocused: Bool
    
    init(coordinator: AuthFlowCoordinator, email: String) {
        self.coordinator = coordinator
        _vm = State(initialValue: PasswordInputViewModel(email: email, coordinator: coordinator))
    }
    
    
    var body: some View {
        @Bindable var vm = vm
        
        VStack {
            Text("PasswordInputView")
            
            Text(vm.email)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

            // MARK: - добавить сф-символ + 2 вида поля (чтобы видеть пароль при надобности)-
            SecureField("Password", text: $vm.password)
                 .focused($isPasswordFocused)
                 .padding(.horizontal)

             if let errorMessage = vm.errorMessage {
                 Text(errorMessage)
                     .foregroundStyle(.red)
                     .font(.footnote)
             }
            
            Button {
                vm.continueTupped()
            } label: {
                Text("Continue")
            }
            
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
            
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    coordinator.goBack()
                } label: {
                    Image(systemName: "chevron.left")
                }
            }
        }
        .appBackground()
        .onAppear {
            isPasswordFocused = true
        }
    }
}


#Preview {
    NavigationStack {
        PasswordInputView(coordinator: AuthFlowCoordinator(), email: "sss@mail.ru")
    }
}


