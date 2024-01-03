//
//  NewContactView.swift
//  chatSwift
//
//  Created by Felipe Avila on 29/12/23.
//

import SwiftUI

struct NewContactView: View {
    @StateObject var viewModel = NewContactViewModel(createRequest: SignUpRequest())
    
    var body: some View {
        VStack(spacing: 24) {
            input(placeholder: "Nome completo", binding: $viewModel.name)
            input(placeholder: "E-mail", binding: $viewModel.email)
            submitButton()
        }
        .navigationTitle("Novo contato")
        .padding()
        
    }
}


extension NewContactView {
    func input(placeholder: String, binding: Binding<String>) -> some View {
        TextField(placeholder, text: binding)
            .padding()
            .background(Color.white)
            .overlay {
                RoundedRectangle(cornerRadius: 12.0)
                    .strokeBorder(Color(UIColor.separator))
            }
    }
    
    func submitButton() -> some View {
        Button("Salvar") {
            viewModel.createContact()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.black)
        .foregroundColor(Color.white)
        .font(Font.title3.bold())
        .cornerRadius(12.0)        
    }
}

struct NewContactView_Previews: PreviewProvider {
    static var previews: some View {
        NewContactView()
    }
}
