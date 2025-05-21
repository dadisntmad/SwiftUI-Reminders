import SwiftUI
import Observation

@Observable
class HomeViewModel {
    var lists: [ReminderListEntity] {
        CoreDataStack.shared.reminderLists
    }
    var reminders: [ReminderEntity] {
        CoreDataStack.shared.reminders
    }
    
    var todaysReminders: [ReminderEntity] {
        let calendar = Calendar.current
        
        return reminders.filter {
            guard let remindAt = $0.remindAt else { return false }
            
            return calendar.isDate(remindAt, inSameDayAs: Date())
        }
    }
    
    var scheduledReminders: [ReminderEntity] {
        let now = Date()
        
        return reminders.filter {
            guard let scheduledDate = $0.remindAt else { return false }
            return scheduledDate > now
        }
    }
    
    var completedReminders: [ReminderEntity] {
        reminders.filter { $0.isCompleted }
    }
    
    func specificListReminders(for list: ReminderListEntity) -> [ReminderEntity] {
        let incompleteReminders = reminders.filter { !$0.isCompleted }
        return incompleteReminders.filter { $0.list == list }
    }
}
