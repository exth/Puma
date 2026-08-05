import SwiftUI


struct ProfileMenuRowView: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .foregroundStyle(.white)
                
                Spacer()
                
                arrowIcon
            }
            .padding(10)
            .padding(.horizontal, 6)
            .frame(width: 300)
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.borderDefault, lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.1), radius: 8)
        }
    }
    
    
    private var arrowIcon: some View {
        Image(systemName: "arrow.right")
            .foregroundStyle(.white)
            .frame(width: 26, height: 26)

    }
}


#Preview {
    VStack(alignment: .leading, spacing: 12) {
        ProfileMenuRowView(title: "Order History") { }
        ProfileMenuRowView(title: "Official Puma Website") { }
    }
    .padding()
}
