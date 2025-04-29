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
        reminders
    }
    
    var scheduledReminders: [ReminderEntity] {
        reminders
    }
    
    var completedReminders: [ReminderEntity] {
        reminders
    }
    
    func addList(color: Color, icon: String, title: String) {
        CoreDataStack.shared.addList(
            color: color.description,
            icon: icon,
            title: title
        )
    }
    
    func deleteList(item: ReminderListEntity) {
        CoreDataStack.shared.deleteList(item: item)
    }
}
