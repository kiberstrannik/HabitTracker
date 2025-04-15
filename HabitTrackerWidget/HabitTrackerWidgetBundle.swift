//
//  HabitTrackerWidgetBundle.swift
//  HabitTrackerWidget
//
//  Created by Nikita on 26/02/2025.
//

import WidgetKit
import SwiftUI

@main
struct HabitTrackerWidgetBundle: WidgetBundle {
    var body: some Widget {
        HabitTrackerWidget()
        HabitTrackerWidgetControl()
        HabitTrackerWidgetLiveActivity()
    }
}
