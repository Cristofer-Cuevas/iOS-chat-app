//
//  ContactsListViewModel.swift
//  ChatApp
//
//  Created by GNIAL App on 2/2/25.
//

import Foundation


@Observable class ContactsListViewModel {
    
    var socketManager: SocketService
    
    var contacts: ContactsResponse
    var isLoading: Bool
    var searchText: String {
        didSet {
            updateFilteredContacts()
        }
    }
    
    var connectedUsers = [""] {
        didSet {
            if !contacts.contacts.isEmpty {
                setUserList()
            }
            
        }
    }
    
    var selectedOption: FilterModel {
        didSet {
            print("the selected option is: ", selectedOption)
            updateFilteredContacts()
        }
    }
    
    var filteredContacts: [UserList] = []
    
    var userList: [UserList] = []
    
    init(contacts: ContactsResponse, isLoading: Bool, searchText: String, socketManager: SocketService = SocketService.shared, selectedOption: FilterModel) {
        self.isLoading = isLoading
        self.contacts = contacts
        self.searchText = searchText
        self.socketManager = socketManager
        self.selectedOption = selectedOption
        
    }
    
    func setupHandlers() {
        socketManager.socket.on("users connected") {data, ack in
            
            if let users = data[0] as? [String] {
                self.connectedUsers = users
                
                print("connected users:", users)
            }
        }
    }
    
    func setUserList() {
        userList = []
        
        for contacts in contacts.contacts {
            if connectedUsers.contains(where: { $0 == contacts.username}) {
                userList.append(UserList(username: contacts.username, isConnected: true, message: contacts.message))
            } else {
                userList.append(UserList(username: contacts.username, isConnected: false, message: contacts.message))
            }
        }
        updateFilteredContacts()
        print(userList)
        
    }

    func updateFilteredContacts() {
        
        if selectedOption == .all {
            filteredContacts = userList.filter { searchText.isEmpty || $0.username.localizedCaseInsensitiveContains(searchText) }
        } else if selectedOption == .online {
            filteredContacts = userList.filter {$0.isConnected == true }
        } else {
            filteredContacts = userList.filter {$0.isConnected == false }
        }
        

    }
    
    func getContacts () {
        socketManager.socket.connect()
        isLoading.toggle()
        
        
        //                contacts = ContactsResponse(contacts: [ChatApp.Contact(username: "Loxzer", message: Optional("Hola")), ChatApp.Contact(username: "Santiago Gordon", message: nil), ChatApp.Contact(username: "Eadie Miranda", message: Optional("D")), ChatApp.Contact(username: "Adiel MS", message: Optional("Hi")), ChatApp.Contact(username: "Marielena", message: Optional("Hq")), ChatApp.Contact(username: "qwerty", message: Optional("Who are you?")), ChatApp.Contact(username: "Emaan Chester", message: nil), ChatApp.Contact(username: "Saul", message: Optional("Klk")), ChatApp.Contact(username: "Randy", message: Optional("Como la encontraste?")), ChatApp.Contact(username: "Alexie Donnelly", message: nil), ChatApp.Contact(username: "Eliezer", message: Optional("Hola")), ChatApp.Contact(username: "Dan", message: Optional("Hello")), ChatApp.Contact(username: "Elias", message: nil), ChatApp.Contact(username: "Clara RIce", message: Optional("Hey, how is it going?")), ChatApp.Contact(username: "mohan", message: Optional("Hi")), ChatApp.Contact(username: "Marlon Coates", message: Optional("Hello")), ChatApp.Contact(username: "Matthias", message: Optional("No")), ChatApp.Contact(username: "ramonmateo", message: nil), ChatApp.Contact(username: "Robert", message: Optional("Very good indeed")), ChatApp.Contact(username: "Ledesma", message: Optional("Weyyyy")), ChatApp.Contact(username: "Jose", message: nil), ChatApp.Contact(username: "Jazer", message: nil), ChatApp.Contact(username: "sabrina", message: Optional(":)!")), ChatApp.Contact(username: "brom", message: nil), ChatApp.Contact(username: "elpepe", message: Optional(".")), ChatApp.Contact(username: "EduardoOller", message: Optional("Hello")), ChatApp.Contact(username: "Uridis", message: Optional("Hello")), ChatApp.Contact(username: "Jhoneudy", message: Optional("Hola!")), ChatApp.Contact(username: "google", message: Optional("Who are you?")), ChatApp.Contact(username: "google1", message: Optional("Hello")), ChatApp.Contact(username: "vitu", message: Optional("Who are you?")), ChatApp.Contact(username: "google12", message: Optional("Who are you?")), ChatApp.Contact(username: "test", message: Optional("Who are you?")), ChatApp.Contact(username: "test", message: Optional("Who are you?")), ChatApp.Contact(username: "Bob", message: Optional("Hello")), ChatApp.Contact(username: "Fede", message: Optional("Hello")), ChatApp.Contact(username: "Alex Paul", message: nil), ChatApp.Contact(username: "Pedro", message: nil), ChatApp.Contact(username: "Maria", message: nil), ChatApp.Contact(username: "Hhhhh", message: nil)], user: "Christopher")
        
        
        setupHandlers()
        
        Task {
            do{
                if let response = try? await NetworkManager.shared.getContacts() {
                    contacts = response
                    setUserList()
                    isLoading.toggle()
                }
            }
        }
    }
    
    
    
}

