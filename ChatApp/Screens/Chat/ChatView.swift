//
//  ChatView.swift
//  ChatApp
//
//  Created by GNIAL App on 18/2/25.
//

import SwiftUI

struct ChatView: View {
    @Binding var path: [String]
    @Binding var selectedUser: UserList
    @State var viewModel = ChatViewModel(selectedUser: UserList(username: "", isConnected: false, message: ""), days: "0", isLoading: false)

    
    var body: some View {
        
        VStack {
            HStack {
                Image("backImage")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .onTapGesture {
                        path.removeLast()
                    }
                ContactListCell(contact: selectedUser, isList: false)
            }
            .padding()
            

            if viewModel.messages.messages.count > 0 {
                
            }
            
            MessageBoxView(messages: $viewModel.messages)
            
            Spacer()
            
            ChatFieldView(messages: $viewModel.messages)
                .padding(.bottom, 20)
        }
        .onAppear{
            viewModel.selectedUser = selectedUser
            viewModel.getMessages()
        }
        .navigationBarHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EmptyView() // Hides the default back button
            }
        }
        
        
    }
}

#Preview {
    ChatView(path: .constant(["ChatView"]), selectedUser: .constant(UserList(username: "Christopher", isConnected: true, message: "")))
}
