import SwiftUI


struct SignInView: View {
    let coordinator: AuthFlowCoordinator
    let session: SessionManager
    
    @State private var vm: SignInViewModel
    @FocusState private var isPasswordFocused: Bool
    @State private var isShowingCloseConfirmation = false
    
    init(coordinator: AuthFlowCoordinator, email: String, session: SessionManager) {
        self.coordinator = coordinator
        self.session = session
        _vm = State(initialValue: SignInViewModel(email: email, coordinator: coordinator, session: session))
    }
    
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: isPasswordFocused ? 5 : 25) {
                AnimatedAuthLogo(isFocused: isPasswordFocused)
                
                VStack(spacing: 5) {
                    Text("Welcome Back")
                        .fontWeight(.medium)
                    
                    Text("Sign In with your email and password")
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
                        errorMessage: vm.passwordError?.errorDescription,
                        showsInlineError: false,
                        focusedField: $isPasswordFocused
                    )
                    
                    errorAndResetSection
                        .padding(.top, 6)
                    
                    PrimaryButton(title: "Continue") {
                        isPasswordFocused = false
                        vm.continueTapped()
                    }
                    .disabled(vm.isLoading)
                    .padding(.top)
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
                    isShowingCloseConfirmation = true
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
        .closeConfirmationAlert(isPresented: $isShowingCloseConfirmation, title: "Leave Sign In?") {
            coordinator.close()
        }
        .appBackground()
        .contentShape(Rectangle())
        .onTapGesture {
            isPasswordFocused = false
        }
        .onAppear {
            isPasswordFocused = true
        }
        .alert("Reset Link Sent", isPresented: $vm.isShowingResetAlert) {
            Button("Continue") { }
        } message: {
            Text("We've emailed you a link to reset your password. Check your inbox and follow the instructions to set a new one.")
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
    
    private var resetPasswordButton: some View {
        HStack {
            Spacer()
            Button {
                isPasswordFocused = false
                vm.resetPasswordTapped()
            } label: {
                Text("Reset Password")
                    .font(.caption)
                    .foregroundStyle(Color.textSecondary)
                    .underline(color: Color.textSecondary)
            }
        }
        .padding(.leading, 5)
        .padding(.top, 4)
    }
    
    private var errorAndResetSection: some View {
            HStack(alignment: .top, spacing: 10) {
                if let errorDescription = vm.passwordError?.errorDescription {
                    FieldErrorText(message: errorDescription)
                        .fixedSize(horizontal: false, vertical: true)
                } else {
                    Spacer()
                }
                
                Button {
                    isPasswordFocused = false
                    vm.resetPasswordTapped()
                } label: {
                    Text("Reset Password")
                        .font(.caption)
                        .foregroundStyle(Color.textSecondary)
                        .underline(color: Color.textSecondary)
                }
                .layoutPriority(1) // Кнопка имеет приоритет и не будет сжиматься длинной ошибкой
            }
            .padding(.horizontal, 5)
            .animation(.easeInOut(duration: 0.2), value: vm.passwordError)
        }
}


#Preview {
    NavigationStack {
        SignInView(coordinator: AuthFlowCoordinator(), email: "sss@mail.ru", session: SessionManager())
    }
}
