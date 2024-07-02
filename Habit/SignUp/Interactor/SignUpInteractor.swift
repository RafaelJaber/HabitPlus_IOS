//
//  SignUpInteractor.swift
//  Habit
//
//  Created by Rafael Jáber on 01/07/24.
//

import Foundation
import Combine

class SignUpInteractor {
    private let remoteSignUp: SignUpRemoteDataSource = .shared
    private let remoteSignIn: SignInRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
    
}

extension SignUpInteractor {
    
    func createUser(signUpRequest request: SignUpRequest) -> Future<Bool, AppError> {
        return remoteSignUp.createUser(request: request)
    }
    
    func login(signInRequest request: SignInRequest) -> Future<SignInResponse, AppError> {
        return remoteSignIn.login(request: request)
    }
    
    func insertAuth(userAuth: UserAuth) {
        local.inserUserAuth(userAuth: userAuth)
    }
}
