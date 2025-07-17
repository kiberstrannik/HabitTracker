//
//  Habit.swift
//  HabitTracker
//
//  Created by Nikita on 17/02/2025.
//

import Foundation

struct Habit: Identifiable, Codable {
    var id = UUID()
    var name: String
    var completedDays: Int
}



