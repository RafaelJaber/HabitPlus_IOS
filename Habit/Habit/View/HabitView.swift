//
//  HabitView.swift
//  Habit
//
//  Created by Rafael Jáber on 02/07/24.
//

import Foundation
import SwiftUI

struct HabitView: View {
    
    @ObservedObject var viewModel: HabitViewModel
    
    var body: some View {
        ZStack {
            if case HabitUIState.loading = viewModel.uiState {
                progress
            } else {
                NavigationStack {
                    
                    ScrollView {
                        VStack(spacing: 12) {
                            
                            topContainer
                            
                            addButton
                            
                            if case HabitUIState.emptyList = viewModel.uiState {
                                
                                Spacer(minLength: 60)
                                
                                VStack {
                                    Image(systemName: "exclamationmark.octagon.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24, alignment: .center)
                                    
                                    Text("Nenhum hábito encontrado :(")
                                }
                                
                            } else if case HabitUIState.fullList(let rows) = viewModel.uiState {
                                
                                LazyVStack {
                                    
                                    ForEach(rows) { row in
                                        HabitCardView.init(viewModel: row)
                                    }
                                    
                                }
                                .padding(.horizontal, 14)
                                .navigationDestination(for: HabitShortDetail.self) { shortDetail in
                                    viewModel.habitDetailView(habitShortDetail: shortDetail)
                                }
                                
                                
                            } else if case HabitUIState.error(let msg) = viewModel.uiState {
                                Text("")
                                    .alert(isPresented: .constant(true)) {
                                        Alert(
                                            title: Text("Ops! \(msg)"),
                                            message: Text("Deseja tentar novamente?"),
                                            primaryButton: .default(Text("Sim")) {
                                                viewModel.onAppear()
                                            },
                                            secondaryButton: .cancel()
                                        )
                                            
                                    }
                            }
                        }
                    }
                    .navigationTitle("Meus Hábitos")
                }
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

extension HabitView {
    var progress: some View {
        ProgressView()
    }
}

extension HabitView {
    var topContainer: some View {
        VStack(alignment: .center, spacing: 12, content: {
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50, alignment: .center)
            
            Text(viewModel.title)
                .font(Font.system(.title).bold())
                .foregroundStyle(Color("primaryColor"))
            
            Text(viewModel.headline)
                .font(Font.system(.title3).bold())
                .foregroundStyle(Color("textColor"))
            
            Text(viewModel.desc)
                .font(Font.system(.headline))
                .foregroundStyle(Color("textColor"))
        })
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.gray, lineWidth: 1)
        )
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }
}

extension HabitView {
    var addButton: some View {
        NavigationLink {
            Text("Teste da view")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } label: {
            Label("Criar Hábito", systemImage: "plus.app")
                .modifier(ButtonStyle())
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    HabitView(viewModel: HabitViewModel(interactor: HabitInteractor()))
}
