//
//  SignInUIState.swift
//  Habit
//
//  Created by Rafael Jáber on 20/06/24.
//

import Foundation

enum SignInUIState {
    case none
    case loading
    case goToHomeScreen
    case error(String)
}
