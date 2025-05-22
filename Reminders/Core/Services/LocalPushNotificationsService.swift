import SwiftUI

class LocalPushNotificationsService {
    static func scheduleNotification(reminderId: String?, title: String, date: Date) async {
        let content = UNMutableNotificationContent()
        content.title = "Reminders"
        content.body = title
        content.sound = .default
        
        let triggerDate = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: date
        )
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: reminderId ?? UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        let granted = try? await notificationCenter.requestAuthorization(options: [.alert, .badge, .sound])
        if granted != true {
            print("Notification permission not granted.")
            return
        }
        
        do {
            try await notificationCenter.add(request)
            print("Notification scheduled for: \(date)")
        } catch {
            print("Failed to schedule notification: \(error.localizedDescription)")
        }
    }
    
    static func cancelNotification(reminderId: String) {
        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [reminderId])
        print("Success! Notification with an id \(reminderId) has been cancelled.")
    }
}
