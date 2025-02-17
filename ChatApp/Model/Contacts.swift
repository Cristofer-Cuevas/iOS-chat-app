//
//  Contacts.swift
//  ChatApp
//
//  Created by GNIAL App on 26/1/25.
//

import Foundation

struct Contact: Decodable, Hashable{
    let username: String
    let message: String?
}

struct ContactsResponse: Decodable {
    let contacts: [Contact]
    let user: String
}

struct UserList: Hashable {
    let username: String
    let isConnected: Bool
    let message: String?
    
    
}
