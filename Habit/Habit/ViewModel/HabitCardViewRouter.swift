//
//  HabitCardViewRouter.swift
//  Habit
//
//  Created by Rafael Jáber on 03/07/24.
//

import Foundation
import SwiftUI
import Combine

enum HabitCardViewRouter {
    static func makeHabitDetailView(habitShortDetail detail: HabitShortDetail, habitPublisher: PassthroughSubject<Bool, Never>) -> some View {
        let viewModel = HabitDetailViewModel(id: detail.id, name: detail.name, label: detail.label, interactor: HabitDetailInteractor())
        viewModel.habitPublisher = habitPublisher
        return HabitDetailView(viewModel: viewModel)
    }
}
