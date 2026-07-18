import SwiftUI


struct FavoriteButtonView: View {
    @Binding var isFavorite: Bool
    var size: CGFloat = 25
    var showsShadow: Bool = true
    
    var body: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isFavorite.toggle()
            }
        } label: {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .font(iconFont)
                .fontWeight(.semibold)
                .foregroundStyle(isFavorite ? .white : .black.opacity(0.6))
                .frame(width: size, height: size)
                .background(isFavorite ? Color.red : Color.white)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: isFavorite ? 2 : 0)
                )
                .shadow(color: .black.opacity(showsShadow ? 0.15 : 0), radius: showsShadow ? 3 : 0)
        }
    }
    
    
    private var iconFont: Font {
        size >= 34 ? .subheadline : .caption
    }
}


#Preview {
    @Previewable @State var isFavorite = false
    
    FavoriteButtonView(isFavorite: $isFavorite, size: 34)
        .padding()
}
