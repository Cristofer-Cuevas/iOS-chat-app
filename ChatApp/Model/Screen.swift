//
//  Screen.swift
//  ChatApp
//
//  Created by GNIAL App on 9/2/25.
//

import Foundation

enum Screen: Codable, Hashable {
    case contactList
    case profile(userID: String)
    case settings
}
