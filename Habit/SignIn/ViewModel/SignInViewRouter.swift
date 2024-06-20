//
//  SignInViewRouter.swift
//  Habit
//
//  Created by Rafael Jáber on 20/06/24.
//

import SwiftUI
import Combine

enum SignInViewRouter {
    
    static func makeHomeView() -> some View {
        return HomeView(viewModel: HomeViewModel())
    }
    
    static func makeSignUpView(publisher: PassthroughSubject<Bool, Never>) -> some View {
        let viewModel = SignUpViewModel()
        viewModel.publisher = publisher
        return SignUpView(viewModel: viewModel)
    }
}
