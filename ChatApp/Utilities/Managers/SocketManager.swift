////
////  SocketManager.swift
////  ChatApp
////
////  Created by GNIAL App on 15/2/25.
////
//
import SocketIO
import Foundation



@Observable class SocketService {
    static let shared = SocketService()
    let tokenManager = NetworkManager.shared.tokenManager
    let manager: SocketManager
    let socket: SocketIOClient
    
    var connectedUsers: [String] = []
    var isSocketConnected: Bool = false
    

    
    init() {
        
        let headers: [String: String] = [
            "Authorization": "\(tokenManager.retrieveJWT() ?? "")"
        ]
        print("headersss", headers)
        manager = SocketManager(socketURL: URL(string: "https://chatapp-x49l.onrender.com")!, config: [.log(true), .compress, .extraHeaders(headers)])
        socket = manager.defaultSocket
        setupHandlers()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            print("🔍 Socket status after 3 seconds: \(self.socket.status)")
        }
        
    }

    private func setupHandlers() {
        
        socket.on(clientEvent: .error) { data, ack in
            
            print(data)
            if let error = data.first {
                print("❌ Socket Error: \(error)")
            } else {
                print("❌ Unknown socket error")
            }
        }
        
        
        socket.on(clientEvent: .connect) {data, ack in
            
            print("socket connected")
        }
        
    }
    
    
    func disconnect() {
        socket.disconnect()
    }
    
}


