//
//  Messages.swift
//  ChatApp
//
//  Created by GNIAL App on 18/2/25.
//

import Foundation


struct Message: Decodable {
    let _id: String
    let sender: String
    let recipient: String
    let message: String
    let date: String
}


struct MessageResponse: Decodable {
    var messages: [Message]
    let requester: String
}
