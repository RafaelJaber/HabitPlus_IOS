//
//  HabitCardView.swift
//  Habit
//
//  Created by Rafael Jáber on 02/07/24.
//

import Foundation
import SwiftUI

struct HabitCardView: View {
    
    let viewModel: HabitCardViewModel
    
    var body: some View {
        ZStack(alignment: .trailing, content: {
            NavigationLink(value: viewModel.id)  {
                HStack {
                    Image(systemName: "pencil")
                        .padding(.horizontal, 8)
                    
                    Spacer()
                    
                    HStack(alignment: .top, content: {
                        
                        VStack(alignment: .leading, spacing: 4, content: {
                            
                            Text(viewModel.name)
                                .foregroundStyle(Color("primaryColor"))
                            
                            Text(viewModel.label)
                                .foregroundStyle(Color("textColor"))
                                .bold()
                            
                            Text(viewModel.date)
                                .foregroundStyle(Color("textColor"))
                                .bold()
                        })
                        .frame(maxWidth: 300, alignment: .leading)
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 4, content: {
                            
                            Text("Registrado")
                                .foregroundStyle(Color("primaryColor"))
                                .bold()
                                .multilineTextAlignment(.leading)
                            
                            Text(viewModel.value)
                                .foregroundStyle(Color("textColor"))
                                .bold()
                                .multilineTextAlignment(.leading)
                            
                            Text("")
                                .multilineTextAlignment(.leading)
                        })
                        
                        Spacer()
                    })
                    .padding()
                    .cornerRadius(4.0)
                }
            }

            Rectangle()
                .frame(width: 8)
                .foregroundColor(viewModel.state)
                .clipShape(.rect(
                    topLeadingRadius: 0,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 4,
                    topTrailingRadius: 4
                ))

        }).background(
            RoundedRectangle(cornerRadius: 4.0)
                .stroke(Color("primaryColor"), lineWidth: 0.3)
                .shadow(color: .gray, radius: 2, x: 2.0, y: 2.0)
        )
        .padding(.horizontal, 4)
        .padding(.vertical, 8)
        
        
    }
}

#Preview {
    NavigationStack {
        List {
            HabitCardView(viewModel: HabitCardViewModel( id: 1,
                                                         icon: "https://picsum.photos/200",
                                                         date: "02/07/2024",
                                                         name: "Tocar guitarra",
                                                         label: "horas",
                                                         value: "2",
                                                         state: .green))
            HabitCardView(viewModel: HabitCardViewModel( id: 2,
                                                         icon: "https://picsum.photos/200",
                                                         date: "02/07/2024",
                                                         name: "Tocar guitarra",
                                                         label: "horas",
                                                         value: "2",
                                                         state: .red))
            HabitCardView(viewModel: HabitCardViewModel( id: 3,
                                                         icon: "https://picsum.photos/200",
                                                         date: "02/07/2024",
                                                         name: "Tocar guitarra",
                                                         label: "horas",
                                                         value: "2",
                                                         state: .yellow))
            HabitCardView(viewModel: HabitCardViewModel( id: 4,
                                                         icon: "https://picsum.photos/200",
                                                         date: "02/07/2024",
                                                         name: "Tocar guitarra",
                                                         label: "horas",
                                                         value: "2",
                                                         state: .green))
        }
        .listStyle(.plain)
        .frame(maxWidth: .infinity)
        .navigationTitle("Teste")
        .navigationDestination(for: Int.self) { id in
            Text("destination id: \(id)")
        }
    }
    
}
