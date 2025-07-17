//
//  NotificationManager.swift
//  HabitTracker
//
//  Created by Nikita on 17/02/2025.
//

import UserNotifications

class NotificationManager {
    static let shared = NotificationManager() // Singleton
    private init() {}

    func scheduleNotification(habitName: String, hour: Int, minute: Int) {
        let content = UNMutableNotificationContent()
        content.title = "Don't forget about habit!"
        content.body = "Time for \(habitName)!"
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: habitName, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error creating notification: \(error)")
            } else {
                print("Notification to \(habitName) scheduled for \(hour):\(minute)")
            }
        }
    }
}
