//
//  SplashViewModel.swift
//  Habit
//
//  Created by Rafael Jáber on 20/06/24.
//

import SwiftUI
import Combine

class SplashViewModel:ObservableObject {
    
    @Published var uiState: SplashUIState = .loading
    
    private var cancellableAuth: AnyCancellable?
    private var cancellableRefreshToken: AnyCancellable?
    
    private let interactor: SplashInteractor
    
    init(interactor: SplashInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellableAuth?.cancel()
        cancellableRefreshToken?.cancel()
    }
    
    func onAppear() {
        cancellableAuth = interactor.fetchAuth()
            .delay(for: .seconds(2), scheduler: RunLoop.main)
            .receive(on: DispatchQueue.main)
            .sink { userAuth in
                if (userAuth == nil) {
                    self.uiState = .goToSignInScreen
                } else if (Date().timeIntervalSince1970 > userAuth!.expires) {
                    print("token expirou -------")
                    // chamar refresh token na API
                    let refreshRequest = RefreshRequest(token: userAuth!.refreshToken)
                    self.cancellableRefreshToken = self.interactor.refreshToken(refreshRequest: refreshRequest)
                        .receive(on: DispatchQueue.main)
                        .sink(receiveCompletion: { completion in
                            switch(completion) {
                                case .failure(_):
                                    self.uiState = .goToSignInScreen
                                    break
                                default:
                                    break
                            }
                        }, receiveValue: { success in
                            let auth = UserAuth(idToken: success.accessToken,
                                                refreshToken: success.refreshToken,
                                                expires: Date().timeIntervalSince1970 + Double(success.expires),
                                                tokenType: success.tokenType)
                            self.interactor.insertAuth(userAuth: auth)
                            self.uiState = .goToHomeScreen
                        })
                } else {
                    self.uiState = .goToHomeScreen
                }
            }
    }
    
}

extension SplashViewModel {
    func signInView() -> some View {
        return SplashViewRouter.makeSignInView()
    }
    func homeView() -> some View {
        return SplashViewRouter.makeHomeView()
    }
}
