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
        let context = CoreDataStack.shared.container.viewContext
        let entity = ReminderListEntity(context: context)
        
        entity.createdAt = Date()
        entity.reminderColor = color.description
        entity.reminderIcon = icon
        entity.reminderTitle = title
        
        CoreDataStack.shared.addList(item: entity)
    }
    
    func deleteList(item: ReminderListEntity) {
        CoreDataStack.shared.deleteList(item: item)
    }
}
