//
//  LoginViewModel.swift
//  chatSwift
//
//  Created by Felipe Avila on 04/12/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class SignUpViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    
    @Published var isLoading = false
    @Published var hasError = false
    @Published var errorMessage = ""
    
    private let signUpRequest: SignUpRequest
    
    init(signUpRequest: SignUpRequest) {
        self.signUpRequest = signUpRequest
    }
    
    func signUp() {
        self.isLoading = true

        self.signUpRequest.createUser(name: name, email: email, password: password) { errorMessage in
            if let errorMessage = errorMessage {
                self.isLoading = false
                self.hasError = true
                self.errorMessage = errorMessage
                return
            }
            
            self.isLoading = false
            print("USUARIO CRIADO \(self.name)")
        }
    }
}
