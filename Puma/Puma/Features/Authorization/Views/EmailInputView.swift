import SwiftUI


struct EmailInputView: View {
    let coordinator: AuthFlowCoordinator
    
    @State private var vm = EmailInputViewModel()

    @FocusState private var isEmailFocused: Bool
    
    
    var body: some View {
        VStack {
            Text("EmailInputView")
            
            TextField("Email", text: $vm.email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .focused($isEmailFocused)
                .padding(.horizontal)
            
            if let errorMessage = vm.errorMessage {
                Text(errorMessage)
            }
            
            Button {
                vm.continueTapped(coordinator: coordinator)
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
        }
        .appBackground()
        .onAppear {
            isEmailFocused = true
        }
    }
}


#Preview {
    NavigationStack {
        EmailInputView(coordinator: AuthFlowCoordinator())
    }
}
