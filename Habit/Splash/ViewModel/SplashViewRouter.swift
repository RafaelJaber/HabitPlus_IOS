//
//  SplashViewRouter.swift
//  Habit
//
//  Created by Rafael Jáber on 20/06/24.
//

import SwiftUI

enum SplashViewRouter {
    static func makeSignInView() -> some View {
        return SignInView(viewModel: SignInViewModel(interactor: SignInInteractor()))
    }
    
    static func makeHomeView() -> some View {
        return HomeView(viewModel: HomeViewModel())
    }
}
