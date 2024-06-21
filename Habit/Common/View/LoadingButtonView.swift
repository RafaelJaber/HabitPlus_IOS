//
//  LoadingButtonView.swift
//  Habit
//
//  Created by Rafael Jáber on 20/06/24.
//

import SwiftUI

struct LoadingButtonView: View {
    
    var action: () -> Void
    var text: String
    var showProgress: Bool = false
    var disabled: Bool = false
    
    
    var body: some View {
        ZStack {
            Button(action: {
                action()
            }, label: {
                Text(showProgress ? " " : text)
                    .padding(.horizontal, 8)
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .foregroundColor(.white)
                    .font(Font.system(.title3).bold())
                    .background(disabled ? Color("disabledPrimaryColor") : Color("primaryColor"))
                    .cornerRadius(8)
            }).disabled(disabled || showProgress)
            
            ProgressView()
                .progressViewStyle(.circular)
                .opacity(showProgress ? 1 : 0)
        }
    }
}

#Preview {
    LoadingButtonView(action: {
        print("Ola")
    }, text: "Entrar", showProgress: true)
}
