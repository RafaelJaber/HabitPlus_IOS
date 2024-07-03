//
//  HomeViewRouter.swift
//  Habit
//
//  Created by Rafael Jáber on 02/07/24.
//

import Foundation
import SwiftUI

enum HomeViewRouter {
    
    static func makeHabitView(viewModel: HabitViewModel) -> some View {
        return HabitView(viewModel: viewModel)
    }
}
