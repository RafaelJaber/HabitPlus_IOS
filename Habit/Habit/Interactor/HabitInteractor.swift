//
//  HabitInteractor.swift
//  Habit
//
//  Created by Rafael Jáber on 03/07/24.
//

import Foundation
import Combine

class HabitInteractor {
    private let remote: HabitRemoteDataSource = .shared
}

extension HabitInteractor {
  
  func fetchHabits() -> Future<[HabitResponse], AppError> {
    return remote.fetchHabits()
  }
  
}
