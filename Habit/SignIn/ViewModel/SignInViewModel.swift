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
    private var cancellableRequest: AnyCancellable?
    
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
        cancellableRequest?.cancel()
    }
    
    func login() {
        self.uiState = .loading
        
        cancellableRequest = interactor.login(loginRequest: SignInRequest(email: email, password: password))
            .receive(on: DispatchQueue.main)
            .sink { completion in
                // aqui acontece o ERROR ou FINISHED
                switch(completion) {
                    case .failure(let appError):
                        self.uiState = SignInUIState.error(appError.message)
                        break
                    case .finished:
                        break
                }
            } receiveValue: { success in
                // aqui acontece o SUCESSO
                let auth = UserAuth(idToken: success.accessToken,
                                    refreshToken: success.refreshToken,
                                    expires: Date().timeIntervalSince1970 + Double(success.expires),
                                    tokenType: success.tokenType)
                self.interactor.insertAuth(userAuth: auth)
                
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
