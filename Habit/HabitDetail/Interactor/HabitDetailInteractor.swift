//
//  HabitDetailInteractor.swift
//  Habit
//
//  Created by Rafael Jáber on 03/07/24.
//

import Foundation
import Combine

class HabitDetailInteractor {
    
    private let remote: HabitDetailRemoteDataSource = .shared
//    private let local

}

extension HabitDetailInteractor {
    func save(habitId: Int, habitValueRequest request: HabitValueRequest) -> Future<Bool, AppError> {
        return remote.save(habitId: habitId, request: request)
    }
}
