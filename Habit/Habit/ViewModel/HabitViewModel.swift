//
//  HabitViewModel.swift
//  Habit
//
//  Created by Rafael Jáber on 02/07/24.
//

import Foundation

class HabitViewModel: ObservableObject {
    
    @Published var uiState: HabitUIState = .emptyList
    
    @Published var title = "Atenção"
    @Published var headline = "Fique ligado!"
    @Published var desc = "Você está atrasado nos hábitos"
    
    
    func onAppear() {
        self.uiState = .loading
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            var rows: [HabitCardViewModel] = []
            
            rows.append(HabitCardViewModel( id: 1,
                                            icon: "https://picsum.photos/200",
                                            date: "02/07/2024",
                                            name: "Tocar guitarra",
                                            label: "horas",
                                            value: "2",
                                            state: .green))
            rows.append(HabitCardViewModel( id: 2,
                                            icon: "https://picsum.photos/200",
                                            date: "02/07/2024",
                                            name: "Tocar guitarra",
                                            label: "horas",
                                            value: "2",
                                            state: .yellow))
            rows.append(HabitCardViewModel( id: 3,
                                            icon: "https://picsum.photos/200",
                                            date: "02/07/2024",
                                            name: "Tocar guitarra",
                                            label: "horas",
                                            value: "2",
                                            state: .red))
            rows.append(HabitCardViewModel( id: 4,
                                            icon: "https://picsum.photos/200",
                                            date: "02/07/2024",
                                            name: "Tocar guitarra",
                                            label: "horas",
                                            value: "2",
                                            state: .green))
            
            self.uiState = .fullList(rows)
                        
        }
    }
    
}

