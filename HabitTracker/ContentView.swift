//
//  ContentView.swift
//  HabitTracker
//
//  Created by Nikita on 13/02/2025.
//

import SwiftUI
import UserNotifications
import WidgetKit

struct ContentView: View {
    @State private var habits: [Habit] = []
    @State private var showAddHabit = false
    @State private var showEditHabit = false
    @State private var newHabitName = ""
    @State private var reminderHour = 9
    @State private var reminderMinute = 0
    @State private var selectedHabit: Habit?

    var body: some View {
        NavigationView {
            List {
                ForEach(habits.indices, id: \.self) { index in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(habits[index].name)
                                .font(.headline)
                            Text("\(habits[index].completedDays) days in a row")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()

                        // Кнопка +1 день
                        Button(action: {
                            habits[index].completedDays += 1
                        }) {
                            Image(systemName: "plus.circle")
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        .padding(.trailing, 10)

                        // Кнопка редактирования
                        Button(action: {
                            selectedHabit = habits[index]
                            showEditHabit = true
                        }) {
                            Image(systemName: "pencil")
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
                .onDelete(perform: deleteHabit)
            }
            .navigationTitle("Habit Tracker")
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button(action: {
                    showAddHabit = true
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showAddHabit) {
                AddHabitView(habits: $habits)
            }
            .sheet(isPresented: $showEditHabit) {
                if let habit = selectedHabit {
                    EditHabitView(habit: habit, showEditHabit: $showEditHabit)
                }
            }
        }
    }

    // Функция удаления привычки
    private func deleteHabit(at offsets: IndexSet) {
        for index in offsets {
            let habit = habits[index]
            habits.remove(at: index)

            // Удаляем запланированное уведомление
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [habit.name])
        }
    }
}
