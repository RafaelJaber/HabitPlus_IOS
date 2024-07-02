//
//  SignUpViewModel.swift
//  Habit
//
//  Created by Rafael Jáber on 20/06/24.
//

import SwiftUI
import Combine

class SignUpViewModel: ObservableObject {
    
    var publisher: PassthroughSubject<Bool, Never>!
    
    @Published var uiState: SignUpUIState = .none
    @Published var fullName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var document = ""
    @Published var phone = ""
    @Published var birthday = ""
    @Published var gender = Gender.male
    
    private let interactor: SignUpInteractor
    
    private var cancellableSignUp: AnyCancellable?
    private var cancellableSignIn: AnyCancellable?
    
    init(interactor: SignUpInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellableSignUp?.cancel()
        cancellableSignIn?.cancel()
    }
    
    
    func register() {
        self.uiState = .loading
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        
        let dateFormatted = formatter.date(from: birthday)
        
        guard let dateFormatted = dateFormatted else {
            self.uiState = .error("Data inválida \(birthday)")
            return
        }
        
        formatter.dateFormat = "yyyy-MM-dd"
        let birthday = formatter.string(from: dateFormatted)
        
        let signUpRequest: SignUpRequest = SignUpRequest(fullname: fullName,
                                                         email: email,
                                                         password: password,
                                                         document: document,
                                                         phone: phone,
                                                         birthday: birthday,
                                                         gender: gender.index)
        
        cancellableSignUp = interactor.createUser(signUpRequest: signUpRequest)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch(completion) {
                    case .failure(let appError):
                        self.uiState = SignUpUIState.error(appError.message)
                        break
                    case .finished:
                        break
                }
            } receiveValue: { successSignUp in
                if (successSignUp) {
                    self.cancellableSignIn = self.interactor.login(signInRequest: SignInRequest(email: self.email, password: self.password))
                        .receive(on: DispatchQueue.main)
                        .sink { completion in
                            switch(completion) {
                                case .failure(let appError):
                                    self.uiState = .error(appError.message)
                                    break
                                case .finished:
                                    break
                            }
                        } receiveValue: { successSignIn in
                            let auth = UserAuth(idToken: successSignIn.accessToken,
                                                refreshToken: successSignIn.refreshToken,
                                                expires: Date().timeIntervalSince1970 + Double(successSignIn.expires),
                                                tokenType: successSignIn.tokenType)
                            self.interactor.insertAuth(userAuth: auth)
                            
                            self.publisher.send(true)
                            self.uiState = .success
                        }
                }
                
            }
        
    }
    
    func formIsInvalid() -> Bool {
        return !email.isEmail() ||
        password.count < 8 ||
        fullName.count < 3 ||
        !document.isValidCpf() ||
        phone.count != 11 ||
        birthday.count == 8
    }
    
}

extension SignUpViewModel {
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
}
