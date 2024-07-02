//
//  HomeViewModel.swift
//  Habit
//
//  Created by Rafael Jáber on 20/06/24.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
}

extension HomeViewModel {
    func habitView() -> some View {
        return HomeViewRouter.makeHabitView()
    }
}
