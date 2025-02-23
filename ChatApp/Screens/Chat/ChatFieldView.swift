//
//  ChatFieldView.swift
//  ChatApp
//
//  Created by GNIAL App on 18/2/25.
//

import SwiftUI

struct ChatFieldView: View {
    @State var searchText: String = ""
    @Binding var messages: MessageResponse
    var body: some View {
        HStack {
          
            
            ZStack {
                
                if searchText.isEmpty {
                    Text("Start typing to chat")
                        .font(.system(size: 19))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .opacity(0.4)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                
                
                TextField("", text: $searchText)
                    
                    
            }
            .padding(.leading, 17)
            
            Button (action: {
                if !searchText.isEmpty {
                    print(searchText)
                    messages.messages.append(Message(_id: searchText, sender: "Christopher", recipient: "", message: searchText, date: getISO8601Timestamp()))
                    print(messages)
                }
                
                searchText = ""
            }, label: {
                Image("sendMessageImage")
                    .padding(.trailing, 17)
            })
            
           
           
            
        }
        
        .frame(height: 64)
        .background(Color("textFieldColor"))
        .cornerRadius(5.0)
        .padding(.horizontal, 20)
    }
    
    func getISO8601Timestamp() -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds] // ✅ Ensures milliseconds
        return formatter.string(from: Date())
    }
}

#Preview {
    ChatFieldView(messages: .constant( MessageResponse(messages: [Message(_id: "123", sender: "", recipient: "", message: "", date: "")], requester: "")))
}
