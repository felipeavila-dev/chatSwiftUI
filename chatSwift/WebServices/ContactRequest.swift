//
//  ContactRequest.swift
//  chatSwift
//
//  Created by Felipe Avila on 26/12/23.
//

import Foundation
import FirebaseFirestore

enum CompletionData:  Equatable {
    case success([ContactsModel])
    case error(String)
}

class ContactRequest {
    func getContacts(completion: @escaping (CompletionData) -> Void) {
        var contacts: [ContactsModel] = []
        
        Firestore.firestore()
            .collection("users")
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("Erro na consulta")
                    completion(.error(error.localizedDescription))
                    return
                }
                                                
                for data in querySnapshot!.documents {
                    contacts.append(ContactsModel(
                        email: data.data()["email"] as! String,
                        name: data.data()["name"] as! String,
                        uuid: data.data()["uuid"] as! String)
                    )
                }
                
                completion(.success(contacts))

            }
    }
}
