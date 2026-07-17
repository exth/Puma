import SwiftUI


struct InfoView: View {
    let onShowCatalog: () -> Void
    
    @State private var showQuote = false
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                AppLogoView(size: 120)
                    .padding(.top, 5)
                
                VStack(alignment: .leading, spacing: 15) {
                    TextCard(text: InfoContent.brandDescription)
                    TextCard(text: InfoContent.founderVision)
                    
                    portraitSection
                    
                    TextCard(text: InfoContent.founderLegacy)
                    
                    websiteFooter
                    
                    CatalogButton(title: "Show catalog", direction: .trailing, action: onShowCatalog)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 5)
                    
                }
            }
            .padding()
        }
        .onTapGesture {
            withAnimation(.smooth(duration: 0.25)) {
                showQuote = false
            }
        }
        .simultaneousGesture(
            DragGesture()
                .onChanged { _ in
                    if showQuote {
                        withAnimation(.smooth(duration: 0.25)) {
                            showQuote = false
                        }
                    }
                }
        )
        .scrollIndicators(.hidden)
    }
    
    
    private var portraitSection: some View {
        VStack(spacing: 8) {
            Image.rudolfDassler
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(quoteOverlay)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.cardBackground, lineWidth: 2)
                )
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        showQuote = true
                    }
                }
            
            Text(InfoContent.portraitCaption)
                .font(.caption)
        }
    }
    
    private var quoteOverlay: some View {
        ZStack {
            Color.black.opacity(showQuote ? 0.75 : 0)
            
            VStack(spacing: 0) {
                Text(InfoContent.quoteTitle)
                    .font(.title2)
                    .fontWeight(.semibold)
                Text(InfoContent.quoteCopyright)
                    .font(.subheadline)
            }
            .foregroundStyle(.white)
            .shadow(color: .white.opacity(0.6), radius: 5)
            .opacity(showQuote ? 1 : 0)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    private var websiteFooter: some View {
        var text = AttributedString("This application features shoes only. To explore the full PUMA collection, please visit the official website")
        
        if let range = text.range(of: "official website") {
            text[range].foregroundColor = .pumaColor
            text[range].font = .headline
            text[range].link = InfoContent.websiteURL
        }
        
        return Text(text)
            .cardStyle()
    }
}


#Preview {
    InfoView(onShowCatalog: { })
}
