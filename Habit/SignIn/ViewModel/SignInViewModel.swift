//
//  SignInViewModel.swift
//  Habit
//
//  Created by Rafael Jáber on 20/06/24.
//

import SwiftUI
import Combine

class SignInViewModel: ObservableObject {
    
    private var cancellable: AnyCancellable?
    private var publisher = PassthroughSubject<Bool, Never>()
    
    @Published var uiState: SignInUIState = .none
    @Published var email = ""
    @Published var password = ""
    
    init() {
        cancellable = publisher.sink { value in
            print("Usu;ario criado! goToHome: \(value)")
            
            if value {
                self.uiState = .goToHomeScreen
            }
        }
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func login() {
        self.uiState = .loading
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.uiState = .goToHomeScreen
        }
    }
    
    func formIsInvalid() -> Bool {
        return !email.isEmail() || password.count < 8
    }
}

extension SignInViewModel {
    func homeView() -> some View {
        return SignInViewRouter.makeHomeView()
    }
    
    func signUpView() -> some View {
        return SignInViewRouter.makeSignUpView(publisher: publisher)
    }
}
