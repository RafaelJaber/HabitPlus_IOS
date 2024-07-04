//
//  HabitDetailUIState.swift
//  Habit
//
//  Created by Rafael Jáber on 03/07/24.
//

import Foundation

enum HabitDetailUIState: Equatable {
    case none
    case loading
    case sucess
    case error(String)
}
