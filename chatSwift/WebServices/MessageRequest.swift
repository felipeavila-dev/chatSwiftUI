//
//  MessageRequest.swift
//  chatSwift
//
//  Created by Felipe Avila on 29/12/23.
//

import Foundation
import FirebaseFirestore

enum CompletionResponse {
    case success([ContactsModel])
}


class MessageRequest {
    func getMessage(fromId: String, completion: @escaping (CompletionResponse) -> Void) {
        Firestore.firestore()
            .collection("last-message")
            .document(fromId)
            .collection("contacts")
            .addSnapshotListener { querySnapshot, error in
                if let changes = querySnapshot?.documentChanges {
                    var currentContacts: [ContactsModel] = []
                    
                    for doc in changes {
                        if doc.type == .added {
                            let document = doc.document
                            
                            
                            currentContacts.append(ContactsModel(email: document.data()["username"] as! String,
                                                               name: document.data()["username"] as! String,
                                                               uuid: document.documentID,
                                                               lastMessage: document.data()["lastMessage"] as! String,
                                                               timestamp: document.data()["timestamp"] as! UInt))
                        }
                    }
                                        
                    completion(.success(currentContacts))
                }
            }
        
        
        
        
    }
}
