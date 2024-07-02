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
    private let interactor: SignInInteractor
    
    @Published var uiState: SignInUIState = .none
    @Published var email = ""
    @Published var password = ""
    
    init(interactor: SignInInteractor) {
        self.interactor = interactor
        
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
        
        interactor.login(loginRequest: SignInRequest(email: email,
                                                     password: password)) { (successResponse, errorResponse) in
            if let error = errorResponse {
                DispatchQueue.main.async {
                    self.uiState = .error(error.detail.message)
                }
            }
            
            if let success = successResponse {
                DispatchQueue.main.async {
                    print(success)
                    self.uiState = .goToHomeScreen
                }
            }
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
