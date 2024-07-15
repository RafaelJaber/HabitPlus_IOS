//
//  HabitValueRequest.swift
//  Habit
//
//  Created by Rafael Jáber on 03/07/24.
//

import Foundation

struct HabitValueRequest: Encodable {
    let value: String
    
    enum CodingKeys: String, CodingKey {
        case value
    }
}
