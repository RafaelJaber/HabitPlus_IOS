//
//  HabitViewModel.swift
//  Habit
//
//  Created by Rafael Jáber on 02/07/24.
//

import Foundation
import Combine
import SwiftUI

class HabitViewModel: ObservableObject {
    
    @Published var uiState: HabitUIState = .emptyList
    
    @Published var title = ""
    @Published var headline = ""
    @Published var desc = ""

    private var cancellableRequest: AnyCancellable?
    private var cancellableNotify: AnyCancellable?
    private let interactor: HabitInteractor
    
    private let habitPublisher = PassthroughSubject<Bool, Never>()

    init(interactor: HabitInteractor) {
        self.interactor = interactor
        
        cancellableNotify = habitPublisher.sink(receiveValue: { saved in
            print("saved: \(saved)")
        })
        
    }

    deinit {
        cancellableRequest?.cancel()
        cancellableNotify?.cancel()
    }

    
    func onAppear() {
        self.uiState = .loading
        
        cancellableRequest = interactor.fetchHabits()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch(completion) {
                    case .failure(let appError):
                        self.uiState = HabitUIState.error(appError.message)
                        break
                    case .finished:
                        break
                }
            }, receiveValue: {response in
                if response.isEmpty {
                    self.uiState = .emptyList
                    
                    self.title = ""
                    self.headline = "Fique ligado!"
                    self.desc = "Você ainda não possui hábitos!"
                } else {
                    self.uiState = .fullList(
                        response.map {
                            
                            let lastDate = $0.lastDate?.toDate(sourcePattern: "yyyy-MM-dd'T'HH:mm:ss", 
                                                               destPattern: "dd/MM/yyyy HH:mm") ?? ""
                            
                            var state = Color.green
                            self.title = "Muito bom!"
                            self.headline = "Seus hábitos estão em dia"
                            self.desc = ""
                            
                            let dateToCompare = $0.lastDate?.toDate(sourcePattern: "yyyy-MM-dd'T'HH:mm:ss") ?? Date()
                            if dateToCompare < Date() {
                                state = .red
                                self.title = "Atenção"
                                self.headline = "Fique ligado!"
                                self.desc = "Você está atrasado nos hábitos"
                            }

                            
                            return HabitCardViewModel(id: $0.id,
                                                      icon: $0.iconUrl ?? "",
                                                      date: lastDate,
                                                      name: $0.name,
                                                      label: $0.label,
                                                      value: "\($0.value ?? 0)",
                                                      state: state)
                        }
                    )
                }
            })
                        
    }
}
    
extension HabitViewModel {
    func habitDetailView(habitShortDetail: HabitShortDetail) -> some View{
        return HabitCardViewRouter.makeHabitDetailView(habitShortDetail: habitShortDetail, habitPublisher: habitPublisher)
    }
}
