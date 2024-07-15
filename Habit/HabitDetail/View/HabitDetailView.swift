//
//  HabitDetailView.swift
//  Habit
//
//  Created by Rafael Jáber on 03/07/24.
//

import Foundation
import SwiftUI

struct HabitDetailView: View {
    
    @ObservedObject var viewModel: HabitDetailViewModel
    
    @Environment(\.dismiss) var dismiss
    
    init(viewModel: HabitDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 12) {
                Text(viewModel.name)
                    .foregroundStyle(Color("primaryColor"))
                    .font(.title.bold())
                
                Text("Unidade: \(viewModel.label)\n")
            }
            
            VStack {
                TextField("Escreva aqui o valor conquistado", text: $viewModel.value)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(PlainTextFieldStyle())
                    .keyboardType(.numberPad)
                
                Divider()
                    .frame(height: 1)
                    .background(.gray)
                    .opacity(0.8)
            }.padding(.horizontal, 32)
            
            Text("Os registros devem ser feitos em até 24h\nHábitos se constroem todos os dias :)")
                .multilineTextAlignment(.center)
            
            LoadingButtonView(action: {
                viewModel.save()
            }, 
                text: "Salvar",
                showProgress: self.viewModel.uiState == .loading,
                disabled: self.viewModel.value.isEmpty
            )
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            
            Button("Cancelar") {
                self.dismiss()
            }
            .padding(.vertical, 8)
            Spacer()
        }
        .padding(.horizontal, 8)
        .padding(.top, 32)
    }
}

#Preview {
    HabitDetailView(viewModel: HabitDetailViewModel(id: 1, name: "Teste", label: "Label", interactor: HabitDetailInteractor()))
}
