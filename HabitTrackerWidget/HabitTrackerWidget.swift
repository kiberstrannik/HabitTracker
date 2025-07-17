//
//  HabitTrackerWidget.swift
//  HabitTrackerWidget
//
//  Created by Nikita on 26/02/2025.
//

import WidgetKit
import SwiftUI

struct HabitEntry: TimelineEntry {
    let date: Date
    let habitName: String
    let completedDays: Int
}

struct HabitProvider: TimelineProvider {
    func placeholder(in context: Context) -> HabitEntry {
        HabitEntry(date: Date(), habitName: "Reading", completedDays: 5)
    }

    func getSnapshot(in context: Context, completion: @escaping (HabitEntry) -> Void) {
        let entry = HabitEntry(date: Date(), habitName: "Reading", completedDays: 5)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<HabitEntry>) -> Void) {
        let entry = HabitEntry(date: Date(), habitName: "Reading", completedDays: 5)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct HabitTrackerWidgetEntryView: View {
    var entry: HabitProvider.Entry

    var body: some View {
        VStack {
            Text(entry.habitName)
                .font(.headline)
                .padding()
            Text("Days in a row: \(entry.completedDays)")
                .font(.subheadline)
        }
        .containerBackground(.fill.tertiary, for: .widget)
    }
}


struct HabitTrackerWidget: Widget {
    let kind: String = "HabitTrackerWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: HabitProvider()) { entry in
            HabitTrackerWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Habit Tracker")
        .description("Track your habits right from your screen!")
        .supportedFamilies([.systemSmall])
    }
}
