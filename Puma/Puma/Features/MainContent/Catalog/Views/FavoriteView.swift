import SwiftUI


struct FavoriteView: View {
    var body: some View {
        Text("Favorite View")
            .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    NavigationStack {
        FavoriteView()
    }
}
