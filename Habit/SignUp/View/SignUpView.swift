//
//  SignUpView.swift
//  Habit
//
//  Created by Rafael Jáber on 20/06/24.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var viewModel: SignUpViewModel
    
    @State var fullName = ""
    @State var email = ""
    @State var password = ""
    @State var document = ""
    @State var phone = ""
    @State var birthday = ""
    @State var gender = Gender.male
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .center, spacing: 8) {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 48)
                    
                    Text("Cadastro")
                        .foregroundStyle(.orange)
                        .font(Font.system(.title).bold())
                        .padding(.bottom, 8)
                    
                    Spacer()
                    
                    fullNameField
                    
                    emailField
                    
                    passwordField
                    
                    documentField
                    
                    phoneField
                    
                    birthdayField
                    
                    genderField
                    
                    Spacer()
                    
                    registerButton
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 32)
            .background(.white)
            
            if case SignUpUIState.error(let value) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(title: Text("Habit"), message: Text(value), dismissButton: .default(Text("Ok")){
                            // Faz algo quando some o alerta
                        })
                    }
            }
        }
    }
}

extension SignUpView {
    var fullNameField: some View {
        TextField("", text: $fullName)
            .frame(height: 36)
            .textFieldStyle(PlainTextFieldStyle())
            .padding([.horizontal], 4)
            .cornerRadius(8)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.orange))
    }
}

extension SignUpView {
    var emailField: some View {
        TextField("", text: $email)
            .frame(height: 36)
            .textFieldStyle(PlainTextFieldStyle())
            .padding([.horizontal], 4)
            .cornerRadius(8)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.orange))
    }
}

extension SignUpView {
    var passwordField: some View {
        SecureField("", text: $password)
            .frame(height: 36)
            .textFieldStyle(PlainTextFieldStyle())
            .padding([.horizontal], 4)
            .cornerRadius(8)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.orange))
    }
}

extension SignUpView {
    var documentField: some View {
        TextField("", text: $document)
            .frame(height: 36)
            .textFieldStyle(PlainTextFieldStyle())
            .padding([.horizontal], 4)
            .cornerRadius(8)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.orange))
    }
}

extension SignUpView {
    var phoneField: some View {
        TextField("", text: $phone)
            .frame(height: 36)
            .textFieldStyle(PlainTextFieldStyle())
            .padding([.horizontal], 4)
            .cornerRadius(8)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.orange))
    }
}

extension SignUpView {
    var birthdayField: some View {
        TextField("", text: $birthday)
            .frame(height: 36)
            .textFieldStyle(PlainTextFieldStyle())
            .padding([.horizontal], 4)
            .cornerRadius(8)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.orange))
    }
}

extension SignUpView {
    var genderField: some View {
        Picker("Gender", selection: $gender) {
            ForEach(Gender.allCases, id: \.self) { value in
                Text(value.rawValue)
                    .tag(value)
            }
        }
        .pickerStyle(.segmented)
        .padding(.top, 16)
        .padding(.bottom, 32)
    }
}

extension SignUpView {
    var registerButton: some View {
        Button {
            viewModel.register()
            } label: {
                Text("Cadastrar")
                    .padding(.horizontal, 8)
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .foregroundColor(.white)
                    .font(Font.system(.title3).bold())
                    .background(.orange)
                    .cornerRadius(8)
            }
        
    }
}

#Preview {
    SignUpView(viewModel: SignUpViewModel())
}
