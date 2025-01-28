//
//  Contacts.swift
//  ChatApp
//
//  Created by GNIAL App on 26/1/25.
//

import Foundation

struct Contact: Decodable {
    let username: String
    let message: String?
}

struct ContactsResponse: Decodable {
    let contacts: [Contact]
    let user: String
}
