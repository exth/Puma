import SwiftUI
import AuthenticationServices


struct AuthView: View {
    @State private var vm: AuthViewModel
    @State private var logoOffset: CGFloat = 0
    
    @State private var currentNonce: String?

    
    init(session: SessionManager, authService: AuthServiceProtocol) {
        _vm = State(initialValue: AuthViewModel(session: session, authService: authService))
    }
    
    
    var body: some View {
        @Bindable var vm = vm
        
        VStack {
            Spacer()
            
            AppLogoView()
                .offset(y: logoOffset)
            
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 34)
                    .fill(Color.mainDarkColor)
                    .frame(maxWidth: .infinity)
                    .frame(height: 280)
                
                VStack(spacing: 12) {
                    appleButton
                    
                    googleButton
                    
                    Button {
                        vm.showEmailInput()
                    } label: {
                        Text("Sign In or Sign Up")
                            .font(.system(size: 19, weight: .medium))
                            .foregroundStyle(Color.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
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
        .onAppear {
            withAnimation(.easeInOut(duration: 1.3).repeatForever(autoreverses: true)) {
                logoOffset = -20
            }
        }
        .onDisappear {
            logoOffset = 0
        }
    }
    
    
    private var appleButton: some View {
        SignInWithAppleButton(
            .signIn,
            onRequest: { request in
                let nonce = randomNonceString()
                currentNonce = nonce
                request.requestedScopes = [.fullName, .email]
                request.nonce = sha256(nonce)
            },
            onCompletion: { result in
                Task {
                    await vm.handleAppleSignIn(result: result, nonce: currentNonce)
                    currentNonce = nil
                }
            }
        )
        .signInWithAppleButtonStyle(.white)
        .frame(height: 50)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .disabled(vm.isLoading)
    }
    
    
    private var googleButton: some View {
        Button {
            Task {
                await vm.signInWithGoogle()
            }
        } label: {
            HStack(spacing: 8) {
                Image.googlelogo
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)

                Text("Sign in with Google")
                    .font(.system(size: 19, weight: .medium))
                    .foregroundStyle(Color.black)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.white)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .disabled(vm.isLoading)
    }
}


#Preview {
    AuthView(session: SessionManager(), authService: FirebaseAuthService())
        .environment(SessionManager())
}
