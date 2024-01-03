//
//  ChatView.swift
//  chatSwift
//
//  Created by Felipe Avila on 11/12/23.
//

import SwiftUI

struct ChatView: View {
    let contact: ContactsModel
    
    @StateObject var viewModel = ChatViewModel()
    @Namespace var bottomId
    
    var body: some View {
        VStack {
            ScrollViewReader { value in
                ScrollView {
                    ForEach(viewModel.messages, id: \.self) { message in
                        Text(message.text)
                            .padding()
                            .background(
                                message.isMe ? Color(UIColor(white: 0.95, alpha: 1)) : Color(UIColor(white: 0.80, alpha: 1)))
                            .cornerRadius(12.0)
                            .frame(maxWidth: .infinity, alignment: message.isMe ? .trailing : .leading)
                        
                    }
                    .onChange(of: viewModel.messages.count) { newValue in
                        value.scrollTo(bottomId)
                    }
                    
                    Color.clear
                        .frame(height: 1)
                        .id(bottomId)
                }
            }
            .gesture(DragGesture().onChanged({ _ in
                UIApplication.shared.hiddenKeyboard()
            }))
            
            HStack {
                TextField("Digite uma mensagem", text: $viewModel.text, axis: .vertical)
                    .lineLimit(3)
                    .disableAutocorrection(true)
                    .cornerRadius(12.0)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 12.0)
                            .strokeBorder(Color(uiColor: UIColor.separator), style: StrokeStyle(lineWidth: 1.0))
                    )
                
                Button("Enviar") {
                    viewModel.sendMessage(contact: contact)
                }
                .disabled(viewModel.text == "")
                .padding()
                .background(Color.blue)
                .cornerRadius(12.0)
                .foregroundColor(Color.white)
            }
            
        }
        .navigationTitle(contact.name)
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        .onAppear {
            viewModel.getMessages(contact: contact)
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(contact: ContactsModel(email: "email@email.com",
                                        name: "Nome teste",
                                        uuid: UUID().uuidString))
    }
}
