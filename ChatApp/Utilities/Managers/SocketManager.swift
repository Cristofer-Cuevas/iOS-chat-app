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
    static let tokenManager = TokenManager()
    let manager: SocketManager
    let socket: SocketIOClient
    
    
    let headers: [String: String] = [
        "Authorization": "\(tokenManager.retrieveJWT()!)"
    ]
    var connectedUsers: [String] = []
    var isSocketConnected: Bool = false
    

    
    init() {
        manager = SocketManager(socketURL: URL(string: "https://chatapp-x49l.onrender.com")!, config: [.log(true), .compress, .extraHeaders(["Authorization": "\(headers)"])])
        socket = manager.defaultSocket
        setupHandlers()
        
        
        
//        socket.connect()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            print("🔍 Socket status after 3 seconds: \(self.socket.status)")
        }
        
        //        connect()
      
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
            //                self.isSocketConnected = true
            
            print("socket connected")
        }
        
    }
    
    
    
    
    
    func connect() {
        //        socket.connect()
        print("Connecting to socket")
        //        print(tokenManager.retrieveJWT()!)
    }
    
    func disconnect() {
        socket.disconnect()
    }
    
}


