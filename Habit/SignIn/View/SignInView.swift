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
                                    .foregroundStyle(.orange)
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
                    .background(.white)
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
        TextField("", text: $email)
            .frame(height: 36)
            .textFieldStyle(PlainTextFieldStyle())
            .padding([.horizontal], 4)
            .cornerRadius(8)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.orange))
    }
}

extension SignInView {
    var passwordField: some View {
        SecureField("", text: $password)
            .frame(height: 36)
            .textFieldStyle(PlainTextFieldStyle())
            .padding([.horizontal], 4)
            .cornerRadius(8)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.orange))
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
                    .background(.orange)
                    .cornerRadius(8)
            }
        
    }
}

extension SignInView {
    var registerLink: some View {
        VStack {
            Text("Ainda não possui login ativo?")
                .foregroundStyle(.gray)
                .padding(.top, 48)
            
            ZStack {
                NavigationLink {
                    viewModel.signUpView()
                } label: {
                    Text("Realize seu cadastro")
                        .foregroundStyle(.orange)
                }
            }
        }
    }
}

#Preview {
    SignInView(viewModel: SignInViewModel())
}
