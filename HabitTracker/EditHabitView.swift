//
//  EditHabitView.swift
//  HabitTracker
//
//  Created by Nikita on 17/02/2025.
//
import SwiftUI

struct EditHabitView: View {
    @State var habit: Habit
    @Binding var showEditHabit: Bool
    @State private var newName: String
    @State private var reminderHour: Int
    @State private var reminderMinute: Int

    init(habit: Habit, showEditHabit: Binding<Bool>) {
        self.habit = habit
        self._showEditHabit = showEditHabit
        self._newName = State(initialValue: habit.name)
        self._reminderHour = State(initialValue: 9)
        self._reminderMinute = State(initialValue: 0)
    }

    var body: some View {
        VStack {
            TextField("Name of habit", text: $newName)
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

            Button("Save") {
                habit.name = newName
                showEditHabit = false

                // Обновляем уведомление
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [habit.name])
                NotificationManager.shared.scheduleNotification(habitName: newName, hour: reminderHour, minute: reminderMinute)
            }
            .padding()
        }
    }
}

