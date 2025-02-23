//
//  MessageView.swift
//  ChatApp
//
//  Created by GNIAL App on 20/2/25.
//

import SwiftUI

struct MessageView: View {
    @State var message: Message
    @State var isRequester: Bool
    var body: some View {
        HStack {
            VStack (alignment: isRequester ? .trailing : .leading){
                Text(message.message)
                    .fontWeight(isRequester ? .medium : .regular)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    
                    .padding(.horizontal, 20)
                    .padding(.vertical, 20)
                    .background(Color(isRequester ? "onlineColor" : "textFieldColor"))
                    .foregroundColor(isRequester ? .white : .black)
                
                    
                    .cornerRadius(4.0)
                    .frame(minWidth: 50, maxWidth: 250, alignment: isRequester ? .trailing : .leading)
                    
                Text(formatDate(message.date))
                .font(.system(size: 14))
                .opacity(0.4)



            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: isRequester ? .trailing : .leading)
//            .background(.blue)
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
}

func formatDate(_ dateString: String) -> String {
    let inputFormatter = ISO8601DateFormatter()
    inputFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds] // ✅ Supports milliseconds

    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = "h:mm a" // ✅ Converts to 12-hour format (e.g., "7:02 PM")

    if let date = inputFormatter.date(from: dateString) {
        return outputFormatter.string(from: date) // ✅ Returns formatted time
    }
    return "Time not available" // Fallback for errors
}



#Preview {
    MessageView(message: Message(_id: "123", sender: "Adiel", recipient: "Christopher", message: "Hola", date: "2022-05-19T19:02:46.604Z"), isRequester: true)
}
