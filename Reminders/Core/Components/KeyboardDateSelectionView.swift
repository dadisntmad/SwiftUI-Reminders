import SwiftUI

struct KeyboardDateSelectionView: View {
    let isSelected: Bool
    let index: Int
    
    var calendarText: String {
        let calendar = Calendar.current
        let today = Date()
        
        switch index {
        case 0:
            return formattedDate(today)
        case 1:
            return formattedDate(calendar.date(byAdding: .day, value: 1, to: today)!)
        case 2:
            return formattedDate(saturdayDay(from: today, calendar: calendar))
        default:
            return "..."
        }
    }
    
    var title: String {
        switch index {
        case 0:
            return "Today"
        case 1:
            return "Tomorrow"
        case 2:
            return "This Weekend"
        default:
            return "Date & Time"
        }
    }
    
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
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
    
    private func saturdayDay(from date: Date, calendar: Calendar) -> Date {
        var components = calendar.dateComponents([.year, .month, .day], from: date)
        let weekday = calendar.component(.weekday, from: date)
        
        let daysUntilSaturday = (7 - weekday + 7) % 7
        components.day! += daysUntilSaturday == 0 ? 7 : daysUntilSaturday
        
        return calendar.date(from: components) ?? date
    }
}

#Preview {
    KeyboardDateSelectionView(isSelected: false, index: 0)
}
