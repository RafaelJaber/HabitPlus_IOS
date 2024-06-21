//
//  SignInView.swift
//  Habit
//
//  Created by Rafael Jáber on 20/06/24.
//

import SwiftUI

struct SignInView: View {
    
    @ObservedObject var viewModel: SignInViewModel
    
    @State var email = ""
    @State var password = ""
    
    @State var action: Int? = 0
    @State var navigationHidden: Bool = true
    
    var body: some View {
        ZStack {
            if case SignInUIState.goToHomeScreen = viewModel.uiState {
                viewModel.homeView()
            } else {
                NavigationStack {
                    ScrollView {
                        VStack(alignment: .center, spacing: 20) {
                            Spacer(minLength: 36)
                            VStack(alignment: .center, spacing: 8, content: {
                                Image("logo")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.horizontal, 48)
                                
                                Text("Login")
                                    .foregroundStyle(Color("primaryColor"))
                                    .font(Font.system(.title).bold())
                                    .padding(.bottom, 8)
                                
                                Spacer()
                                
                                emailField
                                
                                passwordField
                                
                                Spacer()
                                
                                enterButton
                                
                                registerLink
                            })
                        }
                        
                        if case SignInUIState.error(let value) = viewModel.uiState {
                            Text("")
                                .alert(isPresented: .constant(true)) {
                                    Alert(title: Text("Habit"), message: Text(value), dismissButton: .default(Text("Ok")){
                                        // Faz algo quando some o alerta
                                    })
                                }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, 32)
                    .background(Color("backgroundColor"))
                    .navigationBarTitle("Login", displayMode: .inline)
                    .navigationBarHidden(navigationHidden)
                }
                .onAppear {
                    self.navigationHidden = true
                }
                .onDisappear {
                    self.navigationHidden = false
                }
            }
        }
    }
}

extension SignInView {
    var emailField: some View {
        EditTextView(
            text: $email,
            placeholder: "E-mail",
            keyboard: .emailAddress,
            error: "E-mail inválido",
            failure: !email.isEmail(),
            icon: "envelope"
        )
    }
}

extension SignInView {
    var passwordField: some View {
        EditTextView(
            text: $password,
            placeholder: "Senha",
            keyboard: .default,
            error: "Senha deve conter no mínimo 8 caracteres",
            failure: password.count < 8,
            icon: "lock",
            isSecure: true 
        )
    }
}

extension SignInView {
    var enterButton: some View {
        Button {
            viewModel.login(email: email, password: password)
            } label: {
                Text("Entrar")
                    .padding(.horizontal, 8)
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .foregroundColor(.white)
                    .font(Font.system(.title3).bold())
                    .background(Color("primaryColor"))
                    .cornerRadius(8)
            }
        
    }
}

extension SignInView {
    var registerLink: some View {
        VStack {
            Text("Ainda não possui login ativo?")
                .foregroundStyle(Color("textAuxColor"))
                .padding(.top, 48)
            
            ZStack {
                NavigationLink {
                    viewModel.signUpView()
                } label: {
                    Text("Realize seu cadastro")
                        .foregroundStyle(Color("primaryColor"))
                }
            }
        }
    }
}

#Preview {
    SignInView(viewModel: SignInViewModel())
}
