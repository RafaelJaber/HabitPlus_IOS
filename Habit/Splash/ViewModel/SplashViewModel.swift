//
//  SplashViewModel.swift
//  Habit
//
//  Created by Rafael Jáber on 20/06/24.
//

import SwiftUI

class SplashViewModel:ObservableObject {
    
    @Published var uiState: SplashUIState = .loading
    
    func onAppear() {
//        faz algo assincrono e muda o estado da uiState
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.uiState = .error("Algo deu errado aqui")
            self.uiState = .goToSignInScreen
        }
    }
    
}

extension SplashViewModel {
    func signInView() -> some View {
        return SplashViewRouter.makeSignInView()
    }
}
