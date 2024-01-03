//
//  ChatViewModel.swift
//  chatSwift
//
//  Created by Felipe Avila on 11/12/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
 
class ChatViewModel: ObservableObject {
    @Published var text: String = ""    
    @Published var messages: [MessageModel] = []
    
    var myName = ""
    
    
    func getMessages(contact: ContactsModel) {
        let fromId = Auth.auth().currentUser!.uid
        
        Firestore.firestore()
            .collection("users")
            .document(fromId)
            .getDocument { snapshot, error in
                if let error = error {
                    print("Erro ao buscar usuario")
                    return
                }
                
                if let document = snapshot?.data() {
                    self.myName = document["name"] as! String
                }
            }
        
        Firestore.firestore()
            .collection("conversations")
            .document(fromId)
            .collection(contact.uuid)
            .order(by: "timestamp", descending: false)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Erro ao buscar conversa: \(error.localizedDescription)")
                    return
                }
                
                if let changes = querySnapshot?.documentChanges {
                    for doc in changes {
                        let document = doc.document
//                        print("Documento: \(document.documentID) \(document.data())")
                        
                        let message = MessageModel(uuid: document.documentID,
                                                   text: document.data()["text"] as! String,
                                                   isMe: fromId == document.data()["fromId"] as! String)
                        
                        self.messages.append(message)
                    }
                }
                
            }
    }
    
    func sendMessage(contact: ContactsModel) {
        let fromId = Auth.auth().currentUser!.uid
        let timestamp = Date().timeIntervalSince1970
        
//        let currentText = self.text.trimmingCharacters(in: .whitespacesAndNewlines)
        let text = self.text
        self.text = ""
        
        Firestore.firestore()
            .collection("conversations")
            .document(fromId)
            .collection(contact.uuid)
            .addDocument(data: [
                "text": text,
                "fromId": fromId,
                "toId": contact.uuid,
                "timestamp": UInt(timestamp)
            ]) { error in
                if error != nil {
                    print("Erro ao criar mensagem: \(error!.localizedDescription)")
                    return
                }
                
                Firestore.firestore()
                    .collection("last-message")
                    .document(fromId)
                    .collection("contacts")
                    .document(contact.uuid)
                    .setData([
                        "uid": contact.uuid,
                        "username": contact.name,
                        "timestamp": UInt(timestamp),
                        "lastMessage": text
                    ])
            }
        
        Firestore.firestore()
            .collection("conversations")
            .document(contact.uuid)
            .collection(fromId)
            .addDocument(data: [
                "text": text,
                "fromId": fromId,
                "toId": contact.uuid,
                "timestamp": UInt(timestamp)
            ]) { error in
                if error != nil {
                    print("Erro ao criar mensagem: \(error!.localizedDescription)")
                    return
                }
                
                Firestore.firestore()
                    .collection("last-message")
                    .document(contact.uuid)
                    .collection("contacts")
                    .document(fromId)
                    .setData([
                        "uid": fromId,
                        "username": self.myName,
                        "timestamp": UInt(timestamp),
                        "lastMessage": text,
                    ])
            }        
    }
}
