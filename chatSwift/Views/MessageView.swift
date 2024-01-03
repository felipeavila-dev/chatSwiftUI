//
//  MessageView.swift
//  chatSwift
//
//  Created by Felipe Avila on 11/12/23.
//

import SwiftUI

struct MessageView: View {
    @StateObject var viewModel = MessageViewModel(messageRequest: MessageRequest())
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.contacts, id: \.self) { contact in
                    NavigationLink {
                        ChatView(contact: contact)
                    } label: {
                        ContactMessageRow(contact: contact)
                    }

                }
            }
            .onAppear {
                viewModel.handleEnableRequest(enable: true)
                viewModel.getLastMessages()
            }
            .onDisappear {
                viewModel.handleEnableRequest(enable: false)
            }
            .toolbar {
                ToolbarItem(id: "contacts", placement: ToolbarItemPlacement.navigationBarTrailing, showsByDefault: true) {
                    NavigationLink("Contatos") {
                        ContactsView()
                    }
                }
                
                ToolbarItem(id: "logout", placement: ToolbarItemPlacement.navigationBarTrailing, showsByDefault: true) {
                    Button("Logout") {
                        viewModel.logout()
                    }
                }
            }
        }
    }
}

struct ContactMessageRow: View {
    var contact: ContactsModel
    
    var body: some View {
        HStack {
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 15, height: 15)
            
            VStack(alignment: .leading) {
                Text(contact.name)
                    .font(Font.title3.bold())
                
                if let msg = contact.lastMessage {
                    Text(msg)
                        .foregroundColor(Color(UIColor.gray))
                        .lineLimit(1)
                }
            }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
