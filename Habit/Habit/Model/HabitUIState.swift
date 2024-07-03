//
//  HabitUIState.swift
//  Habit
//
//  Created by Rafael Jáber on 02/07/24.
//

import Foundation

enum HabitUIState: Equatable {
    case loading
    case emptyList
    case fullList([HabitCardViewModel])
    case error(String)
}
