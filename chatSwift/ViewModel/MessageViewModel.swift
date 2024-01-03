//
//  MessageViewModel.swift
//  chatSwift
//
//  Created by Felipe Avila on 11/12/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class MessageViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var contacts: [ContactsModel] = []
    
    private let messageRequest: MessageRequest
    
    init(messageRequest: MessageRequest) {
        self.messageRequest = messageRequest
    }
    
    private var enableRequest = true
    
    func handleEnableRequest(enable: Bool) {
        self.enableRequest = enable
    }
    
    func getLastMessages() {
        
        let fromId = Auth.auth().currentUser!.uid
        
        self.messageRequest.getMessage(fromId: fromId) { contacts in
            switch(contacts) {
            case .success(let contacts):
                if self.enableRequest {
                    self.contacts = contacts
                }
            }
        }
    }
    
    func logout() {
        try? Auth.auth().signOut()
    }
    
}
