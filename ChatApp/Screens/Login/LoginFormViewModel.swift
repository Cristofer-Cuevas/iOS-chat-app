//
//  LoginFormViewModel.swift
//  ChatApp
//
//  Created by GNIAL App on 26/1/25.
//

import Foundation
import Observation

@Observable class LoginFormViewModel {
    var tokenManager = TokenManager()
    
    var username: String
    var password: String
    var errorOccurred: Bool
    var alertItem: AlertItem?
    var isSignUpFailed: Bool
    var isLoginSuccessFul: Bool
    var isLoading: Bool
    var path: [String] = []
    var isValidatingSession: Bool
    
    init(username: String, password: String, alertItem: AlertItem?, errorOccurred: Bool, isSignUpFailed: Bool, isLoginSuccessFul: Bool, isLoading: Bool, isValidatingSession: Bool) {
        self.username = username
        self.password = password
        self.alertItem = alertItem
        self.errorOccurred = errorOccurred
        self.isSignUpFailed = isSignUpFailed
        self.isLoginSuccessFul = isLoginSuccessFul
        self.isLoading = isLoading
        self.isValidatingSession = isValidatingSession
    }
    
    
    func getJWTToken () {
        isLoading.toggle()
        Task {
            do{
                if let response = try? await NetworkManager.shared.getJWTToken(username: username, password: password) {
                    print(response)
                    
                    if response == false {
                        alertItem = AlertContext.invalidCredentials
                        errorOccurred = true
                        isLoading.toggle()
                    } else {
                        print("EXECUTED")
                        isLoginSuccessFul = true
                        isLoading.toggle()
                        path.append("ContactList")
                    }
                    
                }
                
                alertItem = AlertContext.invalidCredentials
            }
        }
    }
    
    func signUp(){
        isLoading.toggle()
        Task {
            do{
                if let response = try? await NetworkManager.shared.signUp(username: username, password: password) {
                    if response == false {
                        alertItem = AlertContext.invalidCredentials
                        errorOccurred = true
                        isSignUpFailed = true
                        isLoading.toggle()
                    } else {
                        isLoginSuccessFul = true
                        isLoading.toggle()
                        path.append("ContactList")
                    }
                }
            }
        }
    }
    
    func signOut () {
        tokenManager.removeJWT()
    }
    
    func validateToken() {
        isValidatingSession.toggle()
        Task {
            
            do {
                if let response = try? await NetworkManager.shared.validateJWTToken() {
                    print("here")
                    print(response)
                    if response.contains("true") {
                        path.append("ContactList")
                        isValidatingSession.toggle()
                    } else {
                        isValidatingSession.toggle()
                    }
                }
            }
        }
    }
}
