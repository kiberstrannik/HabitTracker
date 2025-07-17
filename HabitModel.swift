//
//  HabitModel.swift
//  HabitTracker
//
//  Created by Nikita on 15/02/2025.
//

import Foundation

import Foundation

struct HabitModel: Identifiable, Codable {
    var id = UUID()
    var name: String
    var completedDays: Int
}

