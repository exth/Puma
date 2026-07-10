import SwiftUI


struct AuthView: View {
    @State private var vm: AuthViewModel
    
    init(session: SessionManager) {
        _vm = State(initialValue: AuthViewModel(session: session))
    }
    
    
    var body: some View {
        @Bindable var vm = vm
        
        VStack {
            Spacer()
            
            AppLogoView()
            
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 34)
                    .fill(Color.mainDarkColor)
                    .frame(maxWidth: .infinity)
                    .frame(height: 280)
                
                VStack(spacing: 12) {
                    // MARK: ЗАМЕНИТЬ НА APPLE
                    Button {
                        //
                    } label: {
                        Text("Continue with Apple")
                            .foregroundStyle(Color.black)
                            .fontWeight(.semibold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                            )
                    }
                    
                    // MARK: ЗАМЕНИТЬ НА GOOGLT
                    Button {
                        //
                    } label: {
                        Text("Continue with Google")
                            .foregroundStyle(Color.black)
                            .fontWeight(.semibold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                            )
                    }
                    
                    Button {
                        vm.showEmailInput()
                    } label: {
                        Text("Sign In or Sign Up")
                            .foregroundStyle(Color.white)
                            .fontWeight(.semibold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.textSecondary)
                            )
                    }
                }
                .padding(.horizontal)
            }
        }
        .sheet(isPresented: $vm.isShowingEmailInput) {
            AuthFlowContainerView()
                .interactiveDismissDisabled(true)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}


#Preview {
    AuthView(session: SessionManager())
        .environment(SessionManager())
}
