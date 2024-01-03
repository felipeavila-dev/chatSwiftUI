//
//  ContentView.swift
//  chatSwift
//
//  Created by Felipe Avila on 04/12/23.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel = SignUpViewModel(signUpRequest: SignUpRequest())
    @State var showPhotoLibrary = false
    
    var body: some View {
        VStack {
            Button {
                showPhotoLibrary = true
            } label: {
                Text("Foto")
                    .frame(width: 130, height: 130)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(Color.white)
                    .cornerRadius(130.0)
                    .padding(.bottom, 40)
            }
            .sheet(isPresented: $showPhotoLibrary) {
                
            }

            
            TextField("Nome", text: $viewModel.name)
                .padding(12)
                .background(Color.white)
                .cornerRadius(16.0)
                .overlay(
                    RoundedRectangle(cornerRadius: 16.0)
                        .strokeBorder(Color(UIColor.separator))
                )
                .padding(.bottom, 12)
            
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
                viewModel.signUp()
            } label: {
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                } else {
                    Text("Cadastrar")
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
            
        }
        .navigationTitle("Cadastro")
        .padding()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
