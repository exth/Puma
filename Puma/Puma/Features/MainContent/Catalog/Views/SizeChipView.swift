import SwiftUI


struct SizeChipView: View {
    let size: Int
    let isAvailable: Bool
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("\(size)")
                .font(.subheadline)
                .foregroundStyle(textColor)
                .frame(width: 44, height: 44)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isSelected ? Color.black : Color.borderDefault, lineWidth: isSelected ? 2 : 1)
                )
        }
        .disabled(!isAvailable)
    }
    
    
    private var textColor: Color {
        isAvailable ? .black : Color.textMuted.opacity(0.5)
    }
    
    private var backgroundColor: Color {
        isSelected ? Color.backgroundSecondary : Color.white
    }
}


#Preview {
    HStack {
        SizeChipView(size: 38, isAvailable: true, isSelected: true) { }
        SizeChipView(size: 39, isAvailable: true, isSelected: false) { }
        SizeChipView(size: 40, isAvailable: false, isSelected: false) { }
    }
}
