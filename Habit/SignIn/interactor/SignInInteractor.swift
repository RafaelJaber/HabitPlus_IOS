//
//  SignInInteractor.swift
//  Habit
//
//  Created by Rafael Jáber on 01/07/24.
//

import Foundation

class SignInInteractor {
    
    private let remote: RemoteDataSource = .shared
//    private let local: LocalDataSource
    
}

extension SignInInteractor {
    
    func login(loginRequest request: SignInRequest, completion: @escaping (SignInResponse?, SignInErrorResponse?) -> Void) {
        remote.login(request: request, completion: completion)
    }
    
}
