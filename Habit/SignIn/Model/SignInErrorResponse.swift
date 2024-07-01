//
//  SignInErrorResponse.swift
//  Habit
//
//  Created by Rafael Jáber on 01/07/24.
//

import Foundation

struct SignInErrorResponse: Decodable {
    
    let detail: SignInDetailErrorResponse
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}

struct SignInDetailErrorResponse: Decodable {
    
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message
    }
}
