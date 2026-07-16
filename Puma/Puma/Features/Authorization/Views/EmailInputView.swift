import SwiftUI


struct EmailInputView: View {
    let coordinator: AuthFlowCoordinator
    
    @State private var vm = EmailInputViewModel()
    @FocusState private var isEmailFocused: Bool
        
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: isEmailFocused ? 0 : 25) {
                AnimatedAuthLogo(isFocused: isEmailFocused)
                
                Text("Sign In or Sign Up")
                    .fontWeight(.medium)
            }
            .padding(.top, isEmailFocused ? 18 : 24)
            
            VStack(spacing: isEmailFocused ? 10 : 24) {
                VStack(spacing: 5) {
                    EmailFieldBox(
                        text: $vm.email,
                        errorMessage: vm.validationError?.errorDescription,
                        focusedField: $isEmailFocused
                    )
                    
                    PrimaryButton(title: "Sign In") {
                        vm.continueTapped(coordinator: coordinator)
                        isEmailFocused = false
                    }
                    
                    createAccountButton
                }
                
                DividerWithLabel()
                    .padding(.horizontal, 5)
                
                SocialAuthButtons(
                    tappedOnApple: { coordinator.close() },
                    tappedOnGoogle: { coordinator.close() }
                )
            }
            .padding(.top, isEmailFocused ? 5 : 32)
            
            Spacer()
            
            TermsOfUseButton(onTap: { isEmailFocused = false })
                .opacity(isEmailFocused ? 0 : 1)
                .allowsHitTesting(!isEmailFocused)
        }
        .padding(.bottom, 5)
        .animation(.easeOut(duration: 0.1), value: isEmailFocused)
        .padding(.horizontal)
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
        .contentShape(Rectangle())
        .onTapGesture {
            isEmailFocused = false
        }
        .onAppear {
            isEmailFocused = true
        }
    }
    
    
    private var createAccountButton: some View {
        HStack(spacing: 4) {
            Text("Don't have an account?")
                .foregroundStyle(Color.textSecondary.opacity(0.7))
            
            Button {
                isEmailFocused = false
                vm.createAccountTapped(coordinator: coordinator)
            } label: {
                Text("Sign Up")
                    .foregroundStyle(Color.textSecondary)
                    .underline(color: Color.textSecondary)
            }
        }
        .font(.caption)
        .padding(.top, isEmailFocused ? 2 : 6)
    }
}


#Preview {
    NavigationStack {
        EmailInputView(coordinator: AuthFlowCoordinator())
    }
}
