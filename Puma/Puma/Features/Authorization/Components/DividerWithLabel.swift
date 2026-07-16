import SwiftUI


struct DividerWithLabel: View {
    var body: some View {
        HStack(spacing: 12) {
            line
            
            Text("OR")
                .font(.caption)
                .foregroundColor(Color.textSecondary)
            
            line
        }
    }
    
    
    private var line: some View {
        Rectangle()
            .frame(maxWidth: .infinity)
            .frame(height: 1)
            .foregroundColor(Color.borderDefault)
    }
}


#Preview {
    DividerWithLabel()
        .padding(.horizontal)
}
