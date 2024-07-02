//
//  HomeView.swift
//  Habit
//
//  Created by Rafael Jáber on 20/06/24.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    @State var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            viewModel.habitView()
                .tabItem {
                    Image(systemName: "rectangle.grid.2x2")
                    Text("Hábitos")
                }.tag(0)
            Text("Conteúdo de gráficos \(selection)")
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Gráficos")
                }.tag(1)
            
            Text("Conteúdo do Perfil \(selection)")
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Perfil")
                }.tag(2)
        }
        .onAppear() {
            UITabBar.appearance().backgroundColor = UIColor(named: "backgroundColor")
        }
        .tint(Color("primaryColor"))
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
