//
//  NewContactViewModel.swift
//  chatSwift
//
//  Created by Felipe Avila on 29/12/23.
//

import Foundation

class NewContactViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var loading: Bool = false
    
    private let createRequest: SignUpRequest
    
    init(createRequest: SignUpRequest) {
        self.createRequest = createRequest
    }
    
    func
    createContact() {
        self.createRequest.registerUser(name: name, email: email, create: true) { error in
            if let error = error {
                print("Erro ao criar novo contato \(error)")
                return
            }
        }
    }
}
