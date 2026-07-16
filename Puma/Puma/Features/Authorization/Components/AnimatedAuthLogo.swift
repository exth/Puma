import SwiftUI


struct AnimatedAuthLogo: View {
    let isFocused: Bool
    
    var body: some View {
        ZStack {
            AppLogoView(size: 125)
                .opacity(isFocused ? 0 : 1)
            
            Text("PUMA")
                .font(.system(size: 55, weight: .black))
                .italic()
                .foregroundColor(.black.opacity(0.05))
                .opacity(isFocused ? 1 : 0)
                .offset(y: isFocused ? 0 : -20)
        }
        .animation(.easeInOut(duration: 0.25), value: isFocused)
    }
}


#Preview {
    AnimatedAuthLogo(isFocused: true)
}
