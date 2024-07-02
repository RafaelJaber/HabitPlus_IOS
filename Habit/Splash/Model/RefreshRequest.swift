//
//  RefreshRequest.swift
//  Habit
//
//  Created by Rafael Jáber on 02/07/24.
//

import Foundation

struct RefreshRequest: Encodable {
    
    let token: String
    
    enum CodingKeys : String, CodingKey {
        case token = "refresh_token"
    }
}
