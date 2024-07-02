//
//  RemoteDataSource.swift
//  Habit
//
//  Created by Rafael Jáber on 01/07/24.
//

import Foundation

class RemoteDataSource {
    
    // Padrao Singleton - Única instância desse objeto vivo na aplicação.
    
    static var shared: RemoteDataSource = RemoteDataSource()
    
    private init() {
    }
    
    func login(request: SignInRequest, completion: @escaping (SignInResponse?, SignInErrorResponse?) -> Void) {
        WebService.call(path: .login, params: [
            URLQueryItem(name: "username", value: request.email),
            URLQueryItem(name: "password", value: request.password),
        ]) {result in
            switch result {
                case .failure(let error, let data):
                    if let data = data {
                        if error == .unauthorized {
                            let response = try? JSONDecoder().decode(SignInErrorResponse.self, from: data)
                            completion(nil, response)
                        }
                    }
                    break
                case.success(let data):
                    let response = try? JSONDecoder().decode(SignInResponse.self, from: data)
                    completion(response, nil)
                    break
            }
        }
    }
}
