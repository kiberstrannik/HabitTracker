//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by Nikita on 17/02/2025.
//

import SwiftUI

struct AddHabitView: View {
    @Binding var habits: [Habit]
    @State private var newHabitName = ""
    @State private var reminderHour = 9
    @State private var reminderMinute = 0
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            TextField("Name of habit", text: $newHabitName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            DatePicker("Reminder time", selection: Binding(
                get: { Calendar.current.date(from: DateComponents(hour: reminderHour, minute: reminderMinute)) ?? Date() },
                set: { newDate in
                    let components = Calendar.current.dateComponents([.hour, .minute], from: newDate)
                    reminderHour = components.hour ?? 9
                    reminderMinute = components.minute ?? 0
                }
            ), displayedComponents: .hourAndMinute)
            .padding()

            Button("Add a habit") {
                if !newHabitName.isEmpty {
                    let newHabit = Habit(name: newHabitName, completedDays: 0)
                    habits.append(newHabit)

                    NotificationManager.shared.scheduleNotification(habitName: newHabitName, hour: reminderHour, minute: reminderMinute)

                    presentationMode.wrappedValue.dismiss()
                }
            }
            .padding()
        }
    }
}
