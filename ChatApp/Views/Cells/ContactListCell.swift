//
//  ContactListCell.swift
//  ChatApp
//
//  Created by GNIAL App on 2/2/25.
//

import SwiftUI

struct ContactListCell: View {
    
    let contact: UserList
    var isList: Bool
    
    var body: some View {
        HStack {
            ZStack {
                
                ZStack {
                    Circle()
                        .stroke(Color.white, lineWidth: 7)
                        .background(Color(contact.isConnected ? "onlineColor": "offlineColor"))
                        .frame(width: 20, height: 20)
                        .cornerRadius(50)
            
                    
                }
                .padding(.horizontal, -36)
                .zIndex(1.0)
                
                Image("avatar")
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            }
            VStack (alignment: .leading){
                Text(contact.username)
                    .fontWeight(.bold)
                
                Text(isList ? contact.message ?? "" : contact.isConnected ? "online" : "offline")
                    
            }
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50, alignment: .leading)
            .padding(.leading)
        
    }
}

#Preview {
    ContactListCell(contact: UserList(username: "Mock User", isConnected: false, message:"Message"), isList: true)
}
