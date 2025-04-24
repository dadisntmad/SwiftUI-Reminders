import SwiftUI

extension Color {
    static func from(name: String) -> Color {
        switch name.lowercased() {
        case "blue": return .blue
        case "red": return .red
        case "orange": return .orange
        case "yellow": return .yellow
        case "green": return .green
        case "purple": return .purple
        case "brown": return .brown
        case "pink": return .pink
        case "cyan": return .cyan
        case "mint": return .mint
        case "teal": return .teal
        case "indigo": return .indigo
        default: return .orange
        }
    }
}

