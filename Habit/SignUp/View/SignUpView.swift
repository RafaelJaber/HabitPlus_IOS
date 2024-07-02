//
//  SignUpView.swift
//  Habit
//
//  Created by Rafael Jáber on 20/06/24.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var viewModel: SignUpViewModel
    
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .center, spacing: 8) {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 48)
                    
                    Text("Cadastro")
                        .foregroundStyle(Color("primaryColor"))
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
            .background(Color("backgroundColor"))
            
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
        EditTextView(
            text: $viewModel.fullName,
            placeholder: "Nome Completo",
            keyboard: .alphabet,
            error: "Preencha o nome completo",
            failure: viewModel.fullName.count < 3,
            icon: "person"
        )
    }
}

extension SignUpView {
    var emailField: some View {
        EditTextView(
            text: $viewModel.email,
            placeholder: "E-mail",
            keyboard: .emailAddress,
            error: "E-mail inválido",
            failure: !viewModel.email.isEmail(),
            icon: "envelope"
        )
    }
}

extension SignUpView {
    var passwordField: some View {
        EditTextView(
            text: $viewModel.password,
            placeholder: "Senha",
            keyboard: .default,
            error: "Senha deve conter no mínimo 8 caracteres",
            failure: viewModel.password.count < 8,
            icon: "lock",
            isSecure: true
        )
    }
}

extension SignUpView {
    var documentField: some View {
        EditTextView(
            text: $viewModel.document,
            placeholder: "CPF",
            keyboard: .numberPad,
            error: "CPF inválido",
            failure: !viewModel.document.isValidCpf(),
            icon: "person.text.rectangle"
        )
    }
}

extension SignUpView {
    var phoneField: some View {
        EditTextView(
            text: $viewModel.phone,
            placeholder: "Celular",
            keyboard: .numberPad,
            error: "Entre com o DDD + 9 digitos",
            failure: viewModel.phone.count != 11,
            icon: "phone"
        )
    }
}

extension SignUpView {
    var birthdayField: some View {
        EditTextView(
            text: $viewModel.birthday,
            placeholder: "Data de Nascimento",
            keyboard: .decimalPad,
            error: "Data deve ser dd/MM/yyyy",
            failure: viewModel.birthday.count == 8,
            icon: "birthday.cake"
        )
    }
}

extension SignUpView {
    var genderField: some View {
        Picker("Gender", selection: $viewModel.gender) {
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
        LoadingButtonView(
            action: {
                viewModel.register()
            },
            text: "Cadastrar",
            showProgress: self.viewModel.uiState == SignUpUIState.loading,
            disabled: viewModel.formIsInvalid()
        )
        
    }
}

#Preview {
    SignUpView(viewModel: SignUpViewModel(interactor: SignUpInteractor()))
}
