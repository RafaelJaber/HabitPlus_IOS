//
//  SplashRemoteDataSource.swift
//  Habit
//
//  Created by Rafael Jáber on 02/07/24.
//

import Foundation
import Combine

class SplashRemoteDataSource {
    
    static var shared: SplashRemoteDataSource = SplashRemoteDataSource()
    
    private init() {
    }
    
    func refreshToken(request: RefreshRequest) -> Future<SignInResponse, AppError> {
        return Future<SignInResponse, AppError> { promise in
            WebService.call(path: .refreshToken, method: .put, body: request) {result in
                switch result {
                    case .failure(let error, let data):
                        if let data = data {
                            if error == .unauthorized {
                                let response = try? JSONDecoder().decode(SignInErrorResponse.self, from: data)
//                                completion(nil, response)
                                promise(.failure(AppError.response(message: response?.detail.message ?? "Erro desconhecido no servidor")))
                            }
                        }
                        break
                    case.success(let data):
                        let response = try? JSONDecoder().decode(SignInResponse.self, from: data)
//                        completion(response, nil)
                        
                        guard let response = response else {
                            return
                        }
                        promise(.success(response))
                        break
                }
            }
        }
    }
}
