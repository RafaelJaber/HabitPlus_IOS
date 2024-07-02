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
    
    private let interactor: SplashInteractor
    
    init(interactor: SplashInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellableAuth?.cancel()
    }
    
    func onAppear() {
        cancellableAuth = interactor.fetchAuth()
            .delay(for: .seconds(2), scheduler: RunLoop.main)
            .receive(on: DispatchQueue.main)
            .sink { userAuth in
                if (userAuth == nil) {
                    self.uiState = .goToSignInScreen
                } else if (Date().timeIntervalSince1970 > Date().timeIntervalSince1970 + Double(userAuth!.expires)) {
                    // chamar refresh token na API
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
