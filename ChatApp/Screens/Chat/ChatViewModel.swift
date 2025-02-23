//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by GNIAL App on 18/2/25.
//

import Foundation

@Observable class ChatViewModel {
    var socketManager: SocketService
    var messages: MessageResponse
    var days: String
    var isLoading: Bool
    var selectedUser: UserList
    
    init(selectedUser: UserList, days: String, isLoading: Bool, socketManager: SocketService = SocketService.shared) {
        messages = MessageResponse(messages: [Message(_id: "", sender: "", recipient: "", message: "", date: "")], requester: "")
        self.socketManager = socketManager
        self.days = days
        self.isLoading = isLoading
        self.selectedUser = selectedUser
//        setupHandlers()
    }
    
    func setupHandlers () {
        socketManager.socket.on("message") {data, ack in
            print("hello")
            
        }
    }
    
    func getMessages() {
        print("getting messages for :", selectedUser)
        isLoading.toggle()
        Task {
            do {
                print("doing requests")
                if let response = try? await NetworkManager.shared.getMessages(username: selectedUser.username, days: days) {
                    
                    messages = response
                    isLoading.toggle()
                    print("From viewModel", messages)
                }
            }
        }
    }
}
