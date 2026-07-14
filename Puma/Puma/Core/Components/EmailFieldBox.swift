import SwiftUI


struct EmailFieldBox: View {
    @Binding var text: String
    let errorMessage: String?
    var focusedField: FocusState<Bool>.Binding

    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Email")
                    .font(.caption)
                    .padding(.leading)

                TextField("Enter email", text: $text)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .focused(focusedField)
                    .padding()
                    .background(Color.backgroundSecondary)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(borderColor, lineWidth: 2)
                    )
            }

            FieldErrorText(message: errorMessage ?? " ")
                .padding(.top, 6)
                .opacity(errorMessage == nil ? 0 : 1)
        }
        .animation(.easeInOut(duration: 0.2), value: errorMessage)
    }

    private var borderColor: Color {
        if errorMessage != nil { return Color.errorRed }
        return focusedField.wrappedValue ? Color.textSecondary : Color.borderDefault
    }
}
