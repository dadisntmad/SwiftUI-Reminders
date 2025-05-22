import SwiftUI
import Observation

@Observable
class ReminderDetailsViewModel {
    func editReminder(
        reminder: ReminderEntity,
        newTitle: String,
        newNotes: String,
        newIsCompleted: Bool
    ) {
        CoreDataStack.shared.editReminder(
            reminder: reminder,
            newTitle: newTitle,
            newNotes: newNotes,
            newIsCompleted: newIsCompleted
        )
    }
    
    func cancelNotification(reminderId: String) {
        LocalPushNotificationsService.cancelNotification(reminderId: reminderId)
    }
}
