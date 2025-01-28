//
//  TokenManager.swift
//  ChatApp
//
//  Created by GNIAL App on 26/1/25.
//

import Security
import CoreData

final class TokenManager {
    
    func storeJWT(token: String) {
        let tokenData = token.data(using: .utf8)
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "JWT",
            kSecValueData as String: tokenData as Any
        ]
        
        
        SecItemDelete(query as CFDictionary) // Remove existing token
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        print(status == errSecSuccess ? "JWT stored" : "Failed to store JWT")
    }
    
    
    
    func retrieveJWT() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "JWT",
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        if status == errSecSuccess, let data = item as? Data {
            return String(data: data, encoding: .utf8)
        }
        
        print("Failed to retrieve JWT.")
        
        return nil
    }
}
