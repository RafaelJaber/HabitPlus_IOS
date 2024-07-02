//
//  SignUpRemoteDataSource.swift
//  Habit
//
//  Created by Rafael Jáber on 01/07/24.
//

import Foundation
import Combine

class SignUpRemoteDataSource {
    
    static var shared: SignUpRemoteDataSource = SignUpRemoteDataSource()
    
    private init() {
    }
    
    func createUser(request: SignUpRequest) -> Future<Bool, AppError> {
        return Future<Bool, AppError> { promise in
            WebService.call(path: .postUser, method: .post, body: request, completion: { result in
                switch result {
                    case .failure(let error, let data):
                        if let data = data {
                            let response = try? JSONDecoder().decode(ErrorResponse.self, from: data)
                            promise(.failure(AppError.response(message: response?.detail ?? "Erro desconhecido no servidor")))
                        }
                        break
                    case .success(_):
                        promise(.success(true))
                        break
                }
            })
        }
    }
}
