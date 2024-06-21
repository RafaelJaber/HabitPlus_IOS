//
//  EditTextView.swift
//  Habit
//
//  Created by Rafael Jáber on 20/06/24.
//

import SwiftUI

struct EditTextView: View {
    
    @Binding var text: String
    
    var placeholder: String = ""
    var keyboard: UIKeyboardType = .default
    var error: String? = nil
    var failure: Bool? = nil
    var icon: String? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if let icon = icon, !icon.isEmpty {
                    Image(systemName: icon)
                        .foregroundStyle(Color("primaryColor"))
                }
                
                TextField(placeholder, text: $text)
                    .keyboardType(keyboard)
                    .foregroundStyle(Color("textColor"))
                    .padding(.leading, 2)
                    .padding(.vertical, 12)
                    .cornerRadius(8)
                    
            }
            .padding(.horizontal, 14)
            .overlay(RoundedRectangle(cornerRadius: 8.0).stroke(Color("primaryColor"), lineWidth: 0.8))
            
            
            
            if let error = error, failure == true, !text.isEmpty {
                Text(error).foregroundStyle(.red)
            }
        }
        .padding(.bottom, 8)
    }
}

#Preview {
    VStack {
        EditTextView(
            text: .constant("22"),
            placeholder: "E-mail",
            error: "Campo inválido",
            failure: true
        ).padding()
    }
}
