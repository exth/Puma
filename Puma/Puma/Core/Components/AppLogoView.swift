import SwiftUI


struct AppLogoView: View {
    var body: some View {
        Image.pumaLogo
            .resizable()
            .frame(width: 144)
    }
}


#Preview {
    AppLogoView()
}
