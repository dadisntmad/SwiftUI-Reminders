
import SwiftUI

struct DetailsSectionView: View {
    let index: Int
    
    var title: String {
        let calendar = Calendar.current
        let today = Date()
        
        switch index {
        case 0:
            return "Today"
        case 1:
            return "Tomorrow"
        case 2:
            return formattedDate(saturdayDay(from: today, calendar: calendar))
        default:
            return "..."
        }
    }
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Details")
                    .font(.system(size: 17))
                
                Text(title)
                    .foregroundStyle(Colors.gray50)
                    .font(.system(size: 15))
            }
            
            Spacer()
            
            Image("caret")
        }
        .padding(12)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM y"
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
    DetailsSectionView(index: 0)
}
