//
//  SignUpUIState.swift
//  Habit
//
//  Created by Rafael Jáber on 20/06/24.
//

import Foundation

enum SignUpUIState: Equatable {
    case none
    case loading
    case success
    case error(String)
}
