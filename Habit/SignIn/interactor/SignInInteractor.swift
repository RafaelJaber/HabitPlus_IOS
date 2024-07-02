//
//  SignInInteractor.swift
//  Habit
//
//  Created by Rafael Jáber on 01/07/24.
//

import Foundation
import Combine

class SignInInteractor {
    
    private let remote: RemoteDataSource = .shared
//    private let local: LocalDataSource
    
}

extension SignInInteractor {
    
    func login(loginRequest request: SignInRequest) -> Future<SignInResponse, AppError> {
        return remote.login(request: request)
    }
    
}
