import SwiftUI


struct TextCard: View {
    let text: String
    
    var body: some View {
        Text(text)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay (
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black.opacity(0.3), lineWidth: 2)
                    .blur(radius: 4)
            )
    }
}


#Preview {
    VStack {
        TextCard(text: "Some text, some text, some text, some text, some text, some text")
    }
    .padding(.horizontal)
}
