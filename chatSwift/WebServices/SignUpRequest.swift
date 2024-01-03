//
//  SignUpRequest.swift
//  chatSwift
//
//  Created by Felipe Avila on 26/12/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class SignUpRequest {
    func createUser(name: String, email: String, password: String, completion: @escaping (String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard let user = authResult?.user.uid, error == nil else {
                completion(error!.localizedDescription)
                return
            }
            
            self.registerUser(name: name, email: email) { err in
                if let err = err {
                    print("Erro ao registrar usuario: \(err)")
                    completion(err)
                    return
                }
                
                print("USUARIO CRIADO \(user)")
                completion(nil)
            }
            
        }
    }
    
    func registerUser(name: String, email: String, create: Bool = false, completion: @escaping (String?) -> Void) {
        let id = Auth.auth().currentUser!.uid
        
        Firestore.firestore()
            .collection("users")
            .document(create ? UUID().uuidString : id)
            .setData([
                "name": name,
                "email": email,
                "uuid": create ? UUID().uuidString : id
            ]) { err in
                completion(err?.localizedDescription)
            }
    }
}
