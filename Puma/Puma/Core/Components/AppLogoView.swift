import SwiftUI


struct AppLogoView: View {
    private var size: CGFloat
    
    init(size: CGFloat = 140) {
        self.size = size
    }
    
    var body: some View {
        Image.pumaLogo
            .resizable()
            .scaledToFit()
            .frame(width: size)
            .offset(x: 7)
    }
}


#Preview {
    AppLogoView()
}
