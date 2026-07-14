import SwiftUI


struct VerificationCodeView: View {
    @State private var vm: VerificationCodeViewModel
    @State private var isShowingCloseConfirmation = false
    
    let coordinator: AuthFlowCoordinator
    
    
    init(coordinator: AuthFlowCoordinator, email: String) {
        self.coordinator = coordinator
        _vm = State(initialValue: VerificationCodeViewModel(email: email))
    }
    
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 25) {
                AppLogoView(size: 125)
                
                VStack(spacing: 5) {
                    Text("Check your email")
                        .fontWeight(.medium)
                    
                    VStack(spacing: 0) {
                        Text("We've sent a confirmation link to")
                        Text(vm.email)
                    }
                    .font(.caption)
                    .foregroundStyle(Color.textSecondary.opacity(0.7))
                }
                
            }
            .padding(.top, 24)
            
            
            VStack(spacing: 10) {
                VStack(spacing: 0) {
                    Text("You can resend the code once")
                    Text("the timer expires")
                }
                .font(.subheadline)
                
                timerSection
                    .frame(height: 50)
            }
            .padding(.top, 32)
            
            VStack(spacing: 24) {
                DividerWithLabel()
                    .padding(.horizontal)
                
                SocialAuthButtons()
            }
            .padding(.top, 10)
            
            Spacer()
            
            TermsOfUseButton()
            
        }
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
        }
        .closeConfirmationAlert(isPresented: $isShowingCloseConfirmation, title: "Leave Sign Up?") {
            coordinator.close()
        }
        .appBackground()
    }
    
    
    private var timerSection: some View {
        Group {
            if vm.isTimerFinished {
                resendButton
            } else {
                Text(vm.formattedTime)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.black)
            }
        }
    }
    
    private var resendButton: some View {
        Button {
            vm.resendLinkTapped()
        } label: {
            Text("Resend link")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(Color.textSecondary)
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(Color.backgroundSecondary)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.borderDefault, lineWidth: 2)
                )
                .shadow(color: Color.textSecondary.opacity(0.2), radius: 5)
        }
    }
}


#Preview {
    NavigationStack {
        VerificationCodeView(coordinator: AuthFlowCoordinator(), email: "sss@gmail.com")
    }
}
