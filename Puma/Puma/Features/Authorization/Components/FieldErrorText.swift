import SwiftUI


struct FieldErrorText: View {
    let message: String

    var body: some View {
        HStack(alignment: .top, spacing: 5) {
            Image(systemName: "exclamationmark.triangle.fill")
            Text(message)
        }
        .font(.caption)
        .foregroundStyle(Color.errorRed)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 5)
    }
}


#Preview {
    FieldErrorText(message: "Some error")
}
