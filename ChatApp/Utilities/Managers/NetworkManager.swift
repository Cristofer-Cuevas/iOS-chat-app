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
            "username": "\(username)",
            "password": "\(password)"
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        //        let responseString = String(data: data, encoding: .utf8) ?? "No Response"
        //
        //        print("\(responseString)")
        
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(Token.self, from: data)
            
            tokenManager.storeJWT(token: response.token)
            
            let tokenValidation = try await validateJWTToken()
            
            try await getContacts()
            
            if tokenValidation.contains("true") {
                return true
            }
            
            print("Responses \(response) \(tokenValidation)")
        
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
    
    
    func getContacts() async throws {
        
        print("getting called")
        
        guard let url = URL(string: baseURL + "chat/contacts") else {
            print("pont 1")
            return
        }
        
        guard let token = tokenManager.retrieveJWT() else {
            print("poin 2")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token, forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("point 3")
            throw URLError(.badServerResponse)
        }
        
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(ContactsResponse.self, from: data).contacts
            
            print("Contacts Response: \(response)")
        
        }catch{
            
            print("\(error)")
        
        }
    }
    
    
    func signUp(username: String, password: String) async throws {
                       
        guard let url = URL(string: baseURL + "sign-up") else {
            return
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
            let decoder = JSONDecoder()
            let response = try decoder.decode(Token.self, from: data)
            
            tokenManager.storeJWT(token: response.token)
        } catch {
            
            print("Sign up error: \(error)")
        }
        
        
        let responseString = String(data: data, encoding: .utf8) ?? "No Response"
        
        print("\(responseString)")
    }
}
