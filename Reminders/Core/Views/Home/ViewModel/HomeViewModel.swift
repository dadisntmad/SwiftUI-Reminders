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
}
