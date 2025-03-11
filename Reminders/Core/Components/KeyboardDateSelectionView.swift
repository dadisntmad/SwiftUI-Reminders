import SwiftUI

struct KeyboardDateSelectionView: View {
    let calendarText: String
    let title: String
    let isSelected: Bool
    
    var body: some View {
        VStack {
            ZStack {
                Capsule()
                    .fill(isSelected ? Color.blue : Color.white)
                    .frame(width: 72, height: 44)
                    .overlay(
                        Capsule()
                            .stroke(isSelected ? Color.blue : Colors.gray40, lineWidth: 0.5)
                    )
                
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(isSelected ? Colors.blue30 : Color.red)
                        .frame(width: 25, height: 8)
                        .clipShape(.rect(topLeadingRadius: 8, topTrailingRadius: 8))
                    
                    Rectangle()
                        .fill(isSelected ? Color.white : Colors.dateBoxColor)
                        .frame(width: 25, height: 18)
                        .overlay {
                            Text(calendarText)
                                .foregroundStyle(isSelected ? Color.blue : Color.black)
                                .font(.system(size: 12, weight: .bold))
                            
                        }
                        .clipShape(.rect(bottomLeadingRadius: 8, bottomTrailingRadius: 8))
                }
            }
            
            Text(title)
                .font(.system(size: 12))
        }
    }
}

#Preview {
    KeyboardDateSelectionView(calendarText: "11", title: "Today", isSelected: false)
}
