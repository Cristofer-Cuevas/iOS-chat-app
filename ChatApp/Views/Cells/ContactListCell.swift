//
//  ContactListCell.swift
//  ChatApp
//
//  Created by GNIAL App on 2/2/25.
//

import SwiftUI

struct ContactListCell: View {
    
    let contact: Contact
    
    var body: some View {
        HStack {
            ZStack {
                
                ZStack {
                    Circle()
                        .stroke(Color.white, lineWidth: 7)
                        .background(Color("onlineColor"))
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
                
                Text(contact.message ?? "")
                    
            }
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50, alignment: .leading)
            .padding(.leading)
        
    }
}

#Preview {
    ContactListCell(contact: Contact(username: "Mock User", message:"Message"))
}
