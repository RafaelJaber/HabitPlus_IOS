//
//  SplashInteractor.swift
//  Habit
//
//  Created by Rafael Jáber on 02/07/24.
//

import Foundation
import Combine

class SplashInteractor {
    private let remote: SplashRemoteDataSource = .shared
    private let local: LocalDataSource = .shared

}

extension SplashInteractor {
    func fetchAuth() -> Future<UserAuth?, Never> {
        return local.getUserAuth()
    }
    
    func insertAuth(userAuth: UserAuth) {
        local.inserUserAuth(userAuth: userAuth)
    }
    
    func refreshToken(refreshRequest request: RefreshRequest) -> Future<SignInResponse, AppError> {
        return remote.refreshToken(request: request)
    }
}
