import SwiftUI


struct ProfileView: View {
    @State private var vm: ProfileViewModel

    init(session: SessionManager) {
        _vm = State(initialValue: ProfileViewModel(session: session))
    }
    
    
    var body: some View {
        VStack(spacing: 16) {
            Text("ProfileView")
            
            Button {
                vm.clearCache()
            } label: {
                Text("Clear Cache")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background(Color.pumaColor)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            
            Button {
                vm.logOut()
            } label: {
                Text("Log Out")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.red)
            }
        }
        .padding()
        .alert("Cache cleared", isPresented: $vm.didClearCache) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("The product cache was cleared. Fresh data will be loaded next time you open the catalog.")
        }
    }
}


#Preview {
    ProfileView(session: SessionManager())
}
