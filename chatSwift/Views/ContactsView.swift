//
//  ContactsView.swift
//  chatSwift
//
//  Created by Felipe Avila on 11/12/23.
//

import SwiftUI

struct ContactsView: View {
    @ObservedObject var viewModel = ContactsViewModel(contactRequest: ContactRequest())
    
    var body: some View {
        
            ZStack {
                if viewModel.isLoading {
                    ProgressView()
                }
                
                List(viewModel.contacts, id: \.self) { contact in
                    if contact.uuid != viewModel.myUser {
                        NavigationLink {
                            ChatView(contact: contact)
                        } label: {
                            HStack {
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                
                                Text(contact.name)
                            }
                        }
                    }
                }
                .refreshable {
                    viewModel.getContacts()
                }
            }
            .onAppear {
                viewModel.getContacts()
            }
            .toolbar {
                ToolbarItem(id: "Novo Contato", placement: .navigationBarTrailing, showsByDefault: true) {
                    NavigationLink("Novo contato") {
                        NewContactView()
                    }
                }
            }
        }
    
}

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView()
    }
}
