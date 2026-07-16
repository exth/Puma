import SwiftUI


struct CatalogButton: View {
    let title: String
    let direction: ArrowDirection
    let action: () -> Void
    
    enum ArrowDirection {
        case leading, trailing
    }
    

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if direction == .leading {
                    Image(systemName: "arrow.left")
                }
                
                Text(title)
                    .font(.headline)
                
                if direction == .trailing {
                    Image(systemName: "arrow.right")
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
            .background(Color.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay (
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black.opacity(0.3), lineWidth: 2)
                    .blur(radius: 4)
            )
        }
        .buttonStyle(.plain)
    }
}


#Preview {
    CatalogButton(title: "Show Catalog", direction: .trailing, action: { })
}
