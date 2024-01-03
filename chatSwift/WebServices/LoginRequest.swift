//
//  SigInRequest.swift
//  chatSwift
//
//  Created by Felipe Avila on 26/12/23.
//

import Foundation
import FirebaseAuth

class LoginRequest {
    func doLogin(email: String, password: String, completion: @escaping (String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { success, error in
            guard let user = success?.user.uid, error == nil else {
                print(error!.localizedDescription)
                completion(error!.localizedDescription)
                return
            }

            completion(nil)
        }
    }
}


