import SwiftUI


enum ProductColor: String, CaseIterable, Identifiable {
    case black
    case white
    case beige
    case red
    case blue
    
    var id: String {
        rawValue
    }
    
    var displayColor: Color {
        switch self {
        case .black: return .black
        case .white: return .white
        case .beige: return Color(red: 0.93, green: 0.86, blue: 0.75)
        case .red: return .red
        case .blue: return .blue
        }
    }
}
