import SwiftUI


struct ProfileView: View {
    @State private var vm: ProfileViewModel
    
    @Environment(\.openURL) private var openURL

    init(session: SessionManager) {
        _vm = State(initialValue: ProfileViewModel(session: session))
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            headerSection
                .padding(.bottom, 10)
            
            menuSection
            descriptionSection
            versionAndTermsSection
            
            HStack {
                clearCacheButton
                deleteAccountButton
            }
            .frame(width: 300)
            .padding(.bottom, 7)
            
            signOutButton
            
            Spacer()
            
            signatureText
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding()
        .appBackground()
        .alert("Cache cleared", isPresented: $vm.didClearCache) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("The product cache was cleared. Fresh data will be loaded next time you open the catalog")
        }
        .unavailableFeatureAlert(isPresented: $vm.isShowingOrderHistoryAlert)
        .signOutAlert(isPresented: $vm.isShowingSignOutAlert) {
            vm.confirmSignOut()
        }
        .deleteAccountAlert(isPresented: $vm.isShowingDeleteAccountAlert) {
            vm.confirmDeleteAccountFirstStep()
        }
        .finalDeleteAccountAlert(isPresented: $vm.isShowingFinalDeleteAccountAlert) {
            vm.confirmDeleteAccountFinalStep()
        }
        .alert("Error", isPresented:Binding(
            get: {
                vm.deleteAccountError != nil
            },
            set: {
                if !$0 {
                    vm.deleteAccountError = nil
                }
            }
        )) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(vm.deleteAccountError ?? "")
        }
    }
    
    
    private var headerSection: some View {
        HStack(spacing: 15) {
            Image.pumaIcon
                .resizable()
                .frame(width: 45, height: 45)
            
            Text("Welcome to Puma!")
                .font(.title3).bold()
        }
        .padding(10)
        .padding(.horizontal, 5)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .overlay (
             RoundedRectangle(cornerRadius: 30)
                  .stroke(Color.cardBackground, lineWidth: 2)
        )
    }
    
    private var menuSection: some View {
        VStack(spacing: 12) {
            ProfileMenuRowView(title: "Order History") {
                vm.orderHistoryTapped()
            }
            
            ProfileMenuRowView(title: "Official Puma Website") {
                openURL(InfoContent.websiteURL)
            }
        }
    }
    
    private var descriptionSection: some View {
        Text(ProfileContent.appDescription)
            .foregroundStyle(Color.textSecondary)
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .offset(x: -3)
            .frame(maxWidth: .infinity)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.cardBackground, lineWidth: 2)
            }
    }
    
    private var versionAndTermsSection: some View {
        HStack {
            Text(vm.appVersion)
                .foregroundStyle(.black)
            
            Spacer()
            
            TermsOfUseButton()
                .offset(y: 0.5)
                .opacity(0.5)
        }
        .padding(10)
        .padding(.horizontal, 6)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.cardBackground, lineWidth: 2)
        }
        .frame(width: 300)
    }
    
    private var clearCacheButton: some View {
        Button {
            vm.clearCache()
        } label: {
            Text("Clear Cache")
                .foregroundStyle(.white)
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.borderDefault, lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.1), radius: 8)
        }
    }
    
    private var deleteAccountButton: some View {
        Button {
            vm.deleteAccountTapped()
        } label: {
            Text(vm.isDeletingAccount ? "Deleting..." : "Delete Account")
                .foregroundStyle(.white)
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.borderDefault, lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.1), radius: 8)
        }
        .disabled(vm.isDeletingAccount)
        .opacity(vm.isDeletingAccount ? 0.5 : 1)
    }
    
    private var signOutButton: some View {
        Button {
            vm.signOutTapped()
        } label: {
            Text("Sign Out")
                .fontWeight(.semibold)
                .foregroundStyle(.black)
                .padding(10)
                .frame(width: 145)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.borderDefault, lineWidth: 1)
                )
        }
    }
    
    private var signatureText: some View {
        Text("exthxrn")
            .font(.caption)
            .foregroundStyle(Color.textMuted.opacity(0.6))
    }
}


#Preview {
    ProfileView(session: SessionManager())
}
