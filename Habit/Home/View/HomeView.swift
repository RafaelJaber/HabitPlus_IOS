//
//  HomeView.swift
//  Habit
//
//  Created by Rafael Jáber on 20/06/24.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        Text("Tela Inicial")
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
