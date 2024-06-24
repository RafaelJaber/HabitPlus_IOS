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
        
        WebService.postUser(fullname: fullName, 
                            email: email,
                            password: password,
                            document: document,
                            phone: phone,
                            birthday: birthday, // TODO: formatar no input do teclado (dd/MM/yyyy -> yyyy-MM-dd)
                            gender: gender.index)
    }
    
    func formIsInvalid() -> Bool {
        return !email.isEmail() ||
        password.count < 8 ||
        fullName.count < 3 ||
        !document.isValidCpf() ||
        phone.count != 11 ||
        birthday.count != 8
    }
    
}

extension SignUpViewModel {
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
}
