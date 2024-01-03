//
//  ContactsModel.swift
//  chatSwift
//
//  Created by Felipe Avila on 11/12/23.
//

import Foundation

struct ContactsModel: Hashable {
    var uuid: String
    var name: String
    var email: String
    
    var lastMessage: String?
    var timestamp: UInt?
    
    init(email: String, name: String, uuid: String, lastMessage: String, timestamp: UInt) {
        self.email = email
        self.name = name
        self.uuid = uuid
        self.lastMessage = lastMessage
        self.timestamp = timestamp
    }
    
    init(email: String, name: String, uuid: String) {
        self.email = email
        self.name = name
        self.uuid = uuid
    }
}
