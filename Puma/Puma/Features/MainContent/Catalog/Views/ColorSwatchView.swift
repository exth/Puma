import SwiftUI


struct ColorSwatchView: View {
    let color: ProductColor
    let isAvailable: Bool
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Circle()
                .fill(color.displayColor)
                .frame(width: 32, height: 32)
                .overlay(
                    Circle()
                        .stroke(Color.black, lineWidth: isSelected ? 2 : 0)
                        .padding(-3)
                )
                .overlay(
                    Circle()
                        .stroke(Color.borderDefault, lineWidth: 1)
                )
                .overlay(unavailableStrike)
                .opacity(isAvailable ? 1 : 0.25)
        }
        .disabled(!isAvailable)
    }
    
    
    @ViewBuilder
    private var unavailableStrike: some View {
        if !isAvailable {
            Rectangle()
                .fill(Color.textMuted)
                .frame(width: 32, height: 1)
                .rotationEffect(.degrees(45))
        }
    }
}


#Preview {
    HStack {
        ColorSwatchView(color: .black, isAvailable: true, isSelected: true) { }
        ColorSwatchView(color: .white, isAvailable: true, isSelected: false) { }
        ColorSwatchView(color: .red, isAvailable: false, isSelected: false) { }
    }
    .padding()
}
