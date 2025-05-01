import SwiftUI
import Observation

@Observable
class NewReminderViewModel {
    func addReminder(title: String, notes: String, remindAt: Date, to list: ReminderListEntity) {
        CoreDataStack.shared.addReminder(
            title: title,
            notes: notes,
            remindAt: remindAt,
            to: list
        )
    }
    
    func deleteReminder(item: ReminderEntity) {
        CoreDataStack.shared.deleteReminder(item: item)
    }
}
