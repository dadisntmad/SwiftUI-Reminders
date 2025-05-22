import SwiftUI
import Observation

@Observable
class NewReminderViewModel {
    func addReminder(title: String, notes: String, remindAt: Date, to list: ReminderListEntity) async {
        CoreDataStack.shared.addReminder(
            title: title,
            notes: notes,
            remindAt: remindAt,
            to: list
        )
        
        await LocalPushNotificationsService.scheduleNotification(
            reminderId: nil,
            title: title,
            date: remindAt
        )
    }
    
    func deleteReminder(item: ReminderEntity) {
        CoreDataStack.shared.deleteReminder(item: item)
    }
}
