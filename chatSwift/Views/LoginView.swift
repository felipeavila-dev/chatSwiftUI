//
//  ContentView.swift
//  chatSwift
//
//  Created by Felipe Avila on 04/12/23.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel(loginRequest: LoginRequest())
    
    var body: some View {
        NavigationView {
            VStack {
                Image("logo")
                    .resizable()
                    .frame(width: 240, height: 180)
                    .scaledToFit()
                
                TextField("E-mail", text: $viewModel.email)
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(16.0)
                    .autocapitalization(.none)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16.0)
                            .strokeBorder(Color(UIColor.separator))
                    )
                    .padding(.bottom, 12)
                
                SecureField("Senha", text: $viewModel.password)
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(16.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16.0)
                            .strokeBorder(Color(UIColor.separator))
                    )
                    .padding(.bottom, 12)
                
                Button {
                    viewModel.login()
                } label: {
                    if viewModel.isLoading {
                        ProgressView()
                            .padding()
                    } else {
                        Text("Entrar")
                            .padding(12)
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .foregroundColor(Color.white)
                            .font(Font.headline.bold())
                            .cornerRadius(12.0)
                    }
                    
                }
                .alert(isPresented: $viewModel.hasError) {
                    Alert(title: Text(viewModel.errorMessage))
                }
                
                Divider()
                    .padding()
                
                
                Button {
                } label: {
                    NavigationLink(destination: {
                        SignUpView()
                    }, label: {
                        Text("Não tem uma conta? Clique aqui!")
                            .foregroundColor(Color.black)
                    })
                }

                
            }
            .navigationTitle("Login")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }
    
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
