import SwiftUI


struct PumaWatermarkView: View {
    var fontSize: CGFloat = 55
    var opacity: Double = 0.05
    
    var body: some View {
        Text("PUMA")
            .font(.system(size: fontSize, weight: .black))
            .italic()
            .foregroundStyle(Color.black.opacity(opacity))
    }
}


#Preview {
    PumaWatermarkView()
}
