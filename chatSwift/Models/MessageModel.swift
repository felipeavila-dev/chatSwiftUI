//
//  MessageModel.swift
//  chatSwift
//
//  Created by Felipe Avila on 11/12/23.
//

import Foundation

struct MessageModel: Hashable {
    var uuid: String
    var text: String
    var isMe: Bool
}
