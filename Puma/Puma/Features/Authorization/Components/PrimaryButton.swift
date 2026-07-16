import SwiftUI


struct PrimaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundStyle(Color.white)
                .fontWeight(.semibold)
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.textSecondary, lineWidth: 2)
                )
        }
    }
}


#Preview {
    PrimaryButton(title: "Continue") { }
        .padding()
}
