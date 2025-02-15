//
//  Alert.swift
//  ChatApp
//
//  Created by GNIAL App on 2/2/25.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}


struct AlertContext {
    static let invalidCredentials = AlertItem(title: Text("Login Failed"), message: Text("The username or password you entered is incorrect. Please try again."), dismissButton: .default(Text("OK")))
}
