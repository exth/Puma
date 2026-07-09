import SwiftUI


struct AppLogoView: View {
    private var size: CGFloat = 140
    
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
