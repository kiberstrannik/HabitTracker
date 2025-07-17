//
//  HabitTrackerApp.swift
//  HabitTracker
//
//  Created by Nikita on 13/02/2025.
//

import SwiftUI
import UserNotifications

@main
struct НазваниеПроектаApp: App {
    init() {
        requestNotificationPermission()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Permission to notify has been granted.")
            } else {
                print("Access to notification denied")
            }
        }
    }
}
