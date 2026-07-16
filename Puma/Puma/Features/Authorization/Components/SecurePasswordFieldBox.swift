import SwiftUI


struct SecurePasswordFieldBox: View {
    var title: String = "Password"
    var placeholder: String = "Enter password"
    @Binding var text: String
    let errorMessage: String?
    var showsInlineError: Bool = true
    var focusedField: FocusState<Bool>.Binding
    var contentType: UITextContentType = .password

    @State private var isPasswordVisible = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.caption)
                    .padding(.leading)

                ZStack(alignment: .trailing) {
                    Group {
                        if isPasswordVisible {
                            TextField(placeholder, text: $text)
                        } else {
                            SecureField(placeholder, text: $text)
                        }
                    }
                    .textContentType(contentType)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .focused(focusedField)
                    .padding()
                    .padding(.trailing, 36)
                    .frame(height: 52)
                    .background(Color.backgroundSecondary)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(borderColor, lineWidth: 2)
                    )

                    Button {
                        withAnimation(.easeInOut(duration: 0.15)) {
                            isPasswordVisible.toggle()
                        }
                    } label: {
                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                            .foregroundStyle(Color.textSecondary)
                            .contentTransition(.symbolEffect(.replace))
                    }
                    .padding(.trailing, 16)
                }
            }

            if showsInlineError {
                FieldErrorText(message: errorMessage ?? " ")
                    .padding(.top, 6)
                    .opacity(errorMessage == nil ? 0 : 1)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: errorMessage)
    }

    private var borderColor: Color {
        if errorMessage != nil { return Color.errorRed }
        return focusedField.wrappedValue ? Color.textSecondary : Color.borderDefault
    }
}
