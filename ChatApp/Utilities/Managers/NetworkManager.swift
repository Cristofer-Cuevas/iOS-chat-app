//
//  NetworkManager.swift
//  ChatApp
//
//  Created by GNIAL App on 26/1/25.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    var tokenManager = TokenManager()
    
    var baseURL = "https://chatapp-x49l.onrender.com/"
    
    func getJWTToken (username: String, password: String) async throws -> Bool {
        guard let url = URL(string: baseURL) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let body: [String: Any] = [
            "username": "Christopher",
            "password": "\(password)"
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        do {
            
            let responseString = String(data: data, encoding: .utf8) ?? "No Response"
            print("\(responseString)")
            
            let decoder = JSONDecoder()
            
            if let response = try? decoder.decode(UserNotFound.self, from: data) {
                if !response.userNotFound {
                    return false
                }
            }
            
            if let response = try? decoder.decode(CredentialEmpty.self, from: data) {
                if !response.isUsernameEmpty && !response.isPasswordEmpty {
                    return false
                }
                return false
            }

            print("aaaaaaa\(response)")
            
            if let response = try? decoder.decode(Token.self, from: data) {
                tokenManager.storeJWT(token: response.token)
                
                let tokenValidation = try await validateJWTToken()
                                
                if tokenValidation.contains("true") {
                    return true
                }
                
                
            }
            
            print("aa\(response)")
            
        }catch{
            
            print("\(error)")
            
            return false
        }
        
        return false
        
    }
    
    func validateJWTToken() async throws -> String {
        
        guard let url = URL(string: baseURL) else {
            throw URLError(.badURL)
        }
        
        guard let token = tokenManager.retrieveJWT() else {
            return "{success: false}"
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token, forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        
        let responseString = String(data: data, encoding: .utf8) ?? "No Response"
        
        return responseString
    }
    
    
    func getContacts() async throws -> ContactsResponse{
        
        print("getting called")
        
        guard let url = URL(string: baseURL + "chat/contacts") else {
            throw URLError(.badURL)
        }
        
        guard let token = tokenManager.retrieveJWT() else {
            throw TokenError.tokenNotFound
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token, forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(ContactsResponse.self, from: data)
            
            
//            print("Contacts Response: \(response)")
            
            return response
            
            
            
        }catch{
            print("\(error)")
            
        }
        
        return ContactsResponse(contacts: [], user: "User Not Found")
    }
    
    
    func signUp(username: String, password: String) async throws -> Bool {
        
        guard let url = URL(string: baseURL + "sign-up") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let body: [String: Any] = [
            "username": "\(username)",
            "password": "\(password)"
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        do {
            
            let responseString = String(data: data, encoding: .utf8) ?? "No Response"
            print("\(responseString)")
            
            let decoder = JSONDecoder()
            
            
            if let response = try? decoder.decode(CredentialEmpty.self, from: data) {
                
                print(response)
                
                if !response.isPasswordEmpty && !response.isUsernameEmpty {
                    return false
                }
                
            }
            
            if let response = try? decoder.decode(Token.self, from: data) {
                if response.success {
                    tokenManager.storeJWT(token: response.token)
                    return true
                }
            }
            
        } catch {
            
            print("Sign up error: \(error)")
        }

        return false
    }
}
