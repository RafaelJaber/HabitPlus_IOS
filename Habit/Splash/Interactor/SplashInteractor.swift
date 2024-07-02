//
//  SplashInteractor.swift
//  Habit
//
//  Created by Rafael Jáber on 02/07/24.
//

import Foundation
import Combine

class SplashInteractor {
//    private let remote:
    private let local: LocalDataSource = .shared

}

extension SplashInteractor {
    func fetchAuth() -> Future<UserAuth?, Never> {
        return local.getUserAuth()
    }
}
