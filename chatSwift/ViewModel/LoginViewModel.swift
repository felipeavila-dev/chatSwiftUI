//
//  LoginViewModel.swift
//  chatSwift
//
//  Created by Felipe Avila on 04/12/23.
//

import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    @Published var isLoading = false
    @Published var hasError = false
    @Published var errorMessage = ""
    
    private let loginRequest: LoginRequest
    
    init(loginRequest: LoginRequest) {
        self.loginRequest = loginRequest
    }
    
    func login() {
        self.isLoading = true
        
        loginRequest.doLogin(email: email, password: password) { error in
            if let error = error {
                self.isLoading = false
                self.hasError = true
                self.errorMessage = error
                return
            }
            
            self.isLoading = false
        }
    }
}
