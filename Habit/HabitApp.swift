//
//  HabitApp.swift
//  Habit
//
//  Created by Rafael Jáber on 20/06/24.
//

import SwiftUI

@main
struct HabitApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView(viewModel: SplashViewModel(interactor: SplashInteractor()))
        }
    }
}
