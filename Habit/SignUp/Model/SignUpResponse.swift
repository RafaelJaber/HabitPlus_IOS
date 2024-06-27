//
//  SignUpResponse.swift
//  Habit
//
//  Created by Rafael Jáber on 26/06/24.
//

import Foundation

struct SignUpResponse: Decodable {
    let detail: String?
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}
