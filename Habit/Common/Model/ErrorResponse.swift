//
//  ErrorResponse.swift
//  Habit
//
//  Created by Rafael Jáber on 27/06/24.
//

import Foundation

struct ErrorResponse: Decodable {
    let detail: String
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}
