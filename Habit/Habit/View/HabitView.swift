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
            } else if case HabitUIState.emptyList = viewModel.uiState {
                
            } else if case HabitUIState.fullList = viewModel.uiState {
                
            } else if case HabitUIState.error = viewModel.uiState {
                
            }
        }
    }
}

extension HabitView {
    var progress: some View {
        ProgressView()
    }
}

#Preview {
    HabitView(viewModel: HabitViewModel())
}
