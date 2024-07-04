//
//  HabitCardViewRouter.swift
//  Habit
//
//  Created by Rafael Jáber on 03/07/24.
//

import Foundation
import SwiftUI

enum HabitCardViewRouter {
    static func makeHabitDetailView(habitShortDetail detail: HabitShortDetail) -> some View {
        let viewModel = HabitDetailViewModel(id: detail.id, name: detail.name, label: detail.label)
        return HabitDetailView(viewModel: viewModel)
    }
}
