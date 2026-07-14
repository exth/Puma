import SwiftUI


struct PasswordInputView: View {
    let coordinator: AuthFlowCoordinator
    
    @State private var vm: PasswordInputViewModel
    @FocusState private var isPasswordFocused: Bool
    
    init(coordinator: AuthFlowCoordinator, email: String ) {
        self.coordinator = coordinator
        _vm = State(initialValue: PasswordInputViewModel(email: email, coordinator: coordinator))
    }
    
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: isPasswordFocused ? 5 : 25) {
                AnimatedAuthLogo(isFocused: isPasswordFocused)
                
                VStack(spacing: 5) {
                    Text("Create Account")
                        .fontWeight(.medium)
                    
                    Text("You must set a password to continue")
                        .font(.caption)
                        .foregroundStyle(Color.textSecondary.opacity(0.7))
                }
                
            }
            .padding(.top, 24)
            
            
            VStack(spacing: 24) {
                
                VStack(spacing: 5) {
                    emailField
                    
                    SecurePasswordFieldBox(
                        text: $vm.password,
                        errorMessage: vm.validationError?.errorDescription,
                        focusedField: $isPasswordFocused
                    )
                    
                    PrimaryButton(title: "Continue") {
                        vm.continueTapped()
                        isPasswordFocused = false
                    }
                }
                .padding(.top, 32)
                
                Spacer()

                TermsOfUseButton(onTap: { isPasswordFocused = false })
                    .opacity(isPasswordFocused ? 0 : 1)
                    .allowsHitTesting(!isPasswordFocused)
            }
        }
        .padding(.bottom, 5)
        .animation(.easeOut(duration: 0.1), value: isPasswordFocused)
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
            
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    coordinator.goBack()
                } label: {
                    Image(systemName: "chevron.left")
                }
            }
        }
        .appBackground()
        .contentShape(Rectangle())
        .onTapGesture {
            isPasswordFocused = false
        }
        .onAppear {
            isPasswordFocused = true
        }
    }
    
    
    private var emailField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Email")
                .font(.caption)
                .padding(.leading)
            
            Text(vm.email)
                .foregroundStyle(Color.textMuted)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.backgroundSecondary)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.borderDefault, lineWidth: 2)
                )
        }
    }
}


#Preview {
    NavigationStack {
        PasswordInputView(coordinator: AuthFlowCoordinator(), email: "sss@mail.ru")
    }
}
