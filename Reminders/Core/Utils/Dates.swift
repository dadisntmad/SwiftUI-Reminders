import SwiftUI

class Dates {
    
    static private func formattedDate(_ date: Date, isFullDate: Bool) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM y"
        
        // 4 May 2025 at 11:00
        if isFullDate {
            formatter.dateFormat = "d MMM yyyy hh:mm"
            
            return formatter.string(from: date)
        }
        
        return formatter.string(from: date)
    }
    
    static private func saturdayDay(from date: Date, calendar: Calendar) -> Date {
        var components = calendar.dateComponents([.year, .month, .day], from: date)
        let weekday = calendar.component(.weekday, from: date)
        
        let daysUntilSaturday = (7 - weekday + 7) % 7
        components.day! += daysUntilSaturday == 0 ? 7 : daysUntilSaturday
        
        return calendar.date(from: components) ?? date
    }
    
    static func getTitle(index: Int, date: Date, time: Date) -> String {
        let calendar = Calendar.current
        let today = Date()
        
        switch index {
        case 0:
            return "Today"
        case 1:
            return "Tomorrow"
        case 2:
            return formattedDate(saturdayDay(from: today, calendar: calendar), isFullDate: false)
        default:
            
            let combinedComponents = getCombinedComponents(calendar: calendar, date: date, time: time)
            
            if let combinedDate = calendar.date(from: combinedComponents) {
                return formattedDate(combinedDate, isFullDate: true)
            }
            
            return ""
        }
    }
    
    static func remindAtDate(date: Date, time: Date) -> Date {
        let calendar = Calendar.current
        let today = Date()
        
        let combinedComponents = getCombinedComponents(calendar: calendar, date: date, time: time)
        
        if let combinedDate = calendar.date(from: combinedComponents) {
            return combinedDate
        }
        
        return today
    }
    
    private static func getCombinedComponents(calendar: Calendar, date: Date, time: Date) -> DateComponents {
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: time)
        
        var combinedComponents = DateComponents()
        combinedComponents.year = dateComponents.year
        combinedComponents.month = dateComponents.month
        combinedComponents.day = dateComponents.day
        combinedComponents.hour = timeComponents.hour
        combinedComponents.minute = timeComponents.minute
        combinedComponents.second = timeComponents.second
        
        return combinedComponents
    }
}
