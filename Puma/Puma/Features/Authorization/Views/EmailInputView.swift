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
}


#Preview {
    NavigationStack {
        EmailInputView(coordinator: AuthFlowCoordinator())
    }
}
