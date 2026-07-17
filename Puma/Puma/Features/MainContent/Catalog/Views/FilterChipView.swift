import SwiftUI


struct FilterChipView: View {
    let filter: CatalogFilter
    let isSelected: Bool
    let namespace: Namespace.ID
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(filter.rawValue)
                .font(.caption)
                .foregroundStyle(textColor)
                .padding(.vertical, 6)
                .padding(.horizontal, 16)
                .background(backgroundView)
        }
    }
    
    
    private var textColor: Color {
        isSelected ? .black : .black.opacity(0.4)
    }
    
    @ViewBuilder
    private var backgroundView: some View {
        if isSelected {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.cardBackground)
                .matchedGeometryEffect(id: "animateBg", in: namespace)
        }
    }
}


#Preview {
    @Previewable @Namespace var animation
    
    HStack {
        FilterChipView(filter: .all, isSelected: true, namespace: animation) { }
        FilterChipView(filter: .lifestyle, isSelected: false, namespace: animation) { }
        FilterChipView(filter: .sport, isSelected: false, namespace: animation) { }
    }
}
