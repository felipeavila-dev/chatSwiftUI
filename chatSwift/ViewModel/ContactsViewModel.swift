//
//  ContactsViewModel.swift
//  chatSwift
//
//  Created by Felipe Avila on 11/12/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ContactsViewModel: ObservableObject {
    @Published var myUser = Auth.auth().currentUser!.uid
    @Published var contacts: [ContactsModel] = []
    @Published var isLoading = false
    
    var isLoaded = false
    private let contactRequest: ContactRequest
    
    init(contactRequest: ContactRequest) {
        self.contactRequest = contactRequest
    }
    
    
    func getContacts() {
        self.isLoading = true
        
        contactRequest.getContacts { completion in
            switch(completion) {
            case .error(let errorMessage):
                print("Erro na consulta: \(errorMessage)")
                self.isLoading = false
                break
                
            case .success(let contacts):
                self.contacts.removeAll()
                self.contacts = contacts
                self.isLoading = false
                break
            }
        }
    }
}
