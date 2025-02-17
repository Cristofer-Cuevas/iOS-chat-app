//
//  Token.swift
//  ChatApp
//
//  Created by GNIAL App on 26/1/25.
//

import Foundation

struct Token: Decodable {
    let success: Bool
    let token: String
}

struct UserNotFound: Decodable {
    let userNotFound: Bool
}

struct CredentialEmpty: Decodable {
    let isUsernameEmpty: Bool
    let isPasswordEmpty: Bool
}

//struct TokenResponse: Decodable {
//    let response: Token
//}
