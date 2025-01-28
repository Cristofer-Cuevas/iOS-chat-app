//
//  LoginFormViewModel.swift
//  ChatApp
//
//  Created by GNIAL App on 26/1/25.
//

import Foundation
import Observation

@Observable class LoginFormViewModel {
    var username: String
    var password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    
    func getJWTToken () {
        Task {
            do{
                try await NetworkManager.shared.getJWTToken(username: username, password: password)
            }catch {
                
                print("second \(error)")
            }
        }
    }
    
    func signUp(){
        Task {
            do{
                try await NetworkManager.shared.signUp(username: username, password: password)
            }catch {
                
                print("second \(error)")
            }
        }
    }
}
