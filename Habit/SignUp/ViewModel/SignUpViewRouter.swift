//
//  SignUpViewRouter.swift
//  Habit
//
//  Created by Rafael Jáber on 20/06/24.
//

import SwiftUI

enum SignUpViewRouter {
    static func makeHomeView() -> some View {
        return HomeView(viewModel: HomeViewModel())
    }
}
