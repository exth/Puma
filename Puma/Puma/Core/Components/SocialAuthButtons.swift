import SwiftUI


struct SocialAuthButtons: View {
    var tappedOnApple: () -> Void = { }
    var tappedOnGoogle: () -> Void = { }
    
    
    var body: some View {
        VStack(spacing: 12) {
            row(text: "Continue With Apple", img: Image.appleLogo, imageSize: 16, tint: Color.white, action: tappedOnApple)
            row(text: "Continue With Google", img: Image.googlelogo, imageSize: 17, tint: nil, action: tappedOnGoogle)
        }
    }
    
    
    private func row(text: String, img: Image, imageSize: CGFloat,
                     tint: Color?, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                img
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageSize)
                    .foregroundStyle(tint ?? .primary)
                
                Text(text)
                    .fontWeight(.semibold)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundStyle(Color.white)
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.borderDefault, lineWidth: 2)
            )
            .shadow(radius: 4)
        }
    }
}


#Preview {
    SocialAuthButtons()
        .padding()
}
