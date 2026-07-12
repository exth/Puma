import SwiftUI


struct EmailInputView: View {
    let coordinator: AuthFlowCoordinator
    
    @State private var vm = EmailInputViewModel()
    @FocusState private var isEmailFocused: Bool
    @State private var isShowingTerms = false
    
    private let termsURL = URL(string: "https://exth.github.io/Puma-terms/")!
    
    
    var body: some View {

        VStack(spacing: 0) {
            VStack(spacing: 25) {
                AppLogoView(size: isEmailFocused ? 50 : 125)
                    .offset(y: isEmailFocused ? -200 : 0)
                    .opacity(isEmailFocused ? 0 : 1)
                    .animation(.easeInOut(duration: 0.2), value: isEmailFocused)
                
                Text("Sign In or Sign Up")
                    .fontWeight(.medium)
            }
            .padding(.top, 24)
            
            VStack(spacing: 24) {
                
                VStack(spacing: 5) {
                    emailField
                    
                    PrimaryButton(title: "Continue") {
                        vm.continueTapped(coordinator: coordinator)
                        isEmailFocused = false
                    }
                }
                
                dividerSection
                
                SocialAuthButtons()
            }
            .padding(.top, 32)
            
                Spacer()
            
            termsButton
                .opacity(isEmailFocused ? 0 : 1)
                .allowsHitTesting(!isEmailFocused)
        }
        .animation(.easeOut(duration: 0.15), value: isEmailFocused)
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
        .sheet(isPresented: $isShowingTerms) {
            SafariView(url: termsURL)
                .ignoresSafeArea()
        }
        
    }
    
    
    
    private var emailField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Email")
                .font(.caption)
                .padding(.leading)

            TextField("Enter email", text: $vm.email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .focused($isEmailFocused)
                .padding()
                .background(Color.backgroundSecondary)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(isEmailFocused ? Color.textSecondary : Color.borderDefault, lineWidth: 2)
                )

            HStack(spacing: 5) {
                Image(systemName: "exclamationmark.triangle.fill")
                Text(vm.validationError?.errorDescription ?? " ")
            }
            .font(.caption)
            .foregroundStyle(Color.textSecondary)
            .opacity(vm.validationError == nil ? 0 : 1)
            .frame(height: 16, alignment: .leading)
            .padding(.leading, 5)
        }
    }
    
    
    
    private var dividerSection: some View {
        HStack(spacing: 12) {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.borderDefault)
            Text("OR")
                .font(.caption)
                .foregroundColor(Color.textSecondary)
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.borderDefault)
        }
    }
    
    
    private var termsButton: some View {
        Button {
            isShowingTerms = true
        } label: {
            Text("Terms of Use")
                .font(.subheadline)
                .foregroundStyle(Color.textSecondary)
                .underline(color: Color.textSecondary)
        }
    }
}


#Preview {
    NavigationStack {
        EmailInputView(coordinator: AuthFlowCoordinator())
    }
}
