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
        
        WebService.postUser(request: SignUpRequest(fullname: fullName,
                                                   email: email,
                                                   password: password,
                                                   document: document,
                                                   phone: phone,
                                                   birthday: birthday,
                                                   gender: gender.index)) { (successResponse, errorResponse) in
            if let error = errorResponse {
                DispatchQueue.main.async {
                    self.uiState = .error(error.detail)
                }
            }
            
            if let success = successResponse {
                WebService.login(request: SignInRequest(email: self.email,
                                                        password: self.password)) { (successResponse, errorResponse) in
                    if let errorSignIn = errorResponse {
                        DispatchQueue.main.async {
                            self.uiState = .error(errorSignIn.detail.message)
                        }
                    }
                    
                    if let successSingIn = successResponse {
                        DispatchQueue.main.async {
                            print(successSingIn)
                            self.publisher.send(success)
                            self.uiState = .success
                        }
                    }
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
