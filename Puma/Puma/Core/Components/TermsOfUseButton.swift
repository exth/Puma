import SwiftUI


struct TermsOfUseButton: View {
    var onTap: () -> Void = {}

    @State private var isShowingTerms = false

    var body: some View {
        Button {
            onTap()
            isShowingTerms = true
        } label: {
            Text("Terms of Use")
                .font(.subheadline)
                .foregroundStyle(Color.textSecondary)
                .underline(color: Color.textSecondary)
        }
        .sheet(isPresented: $isShowingTerms) {
            SafariView(url: AppLinks.termsOfUse)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    TermsOfUseButton()
}
