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
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            tabBarAppearance.backgroundEffect = UIBlurEffect(style: .systemMaterial)
            tabBarAppearance.backgroundColor = UIColor(named: "backgroundColor")?.withAlphaComponent(0.1)
            
            UITabBar.appearance().standardAppearance = tabBarAppearance
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }
            
            UITabBar.appearance().isTranslucent = true
        }
        .tint(Color("primaryColor"))
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
