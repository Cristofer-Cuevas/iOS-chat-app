//
//  ContactsListViewModel.swift
//  ChatApp
//
//  Created by GNIAL App on 2/2/25.
//

import Foundation


@Observable class ContactsListViewModel {
    var contacts: ContactsResponse {
        didSet {
            updateFilteredContacts()
        }
    }
    var isLoading: Bool
    var searchText: String {
        didSet {
            updateFilteredContacts()
        }
    }
    
    var filteredContacts: [Contact] = []
    
    init(contacts: ContactsResponse, isLoading: Bool, searchText: String) {
        self.isLoading = isLoading
        self.contacts = contacts
        self.searchText = searchText
    }
    
 
    func updateFilteredContacts() {
        print("before updating \(contacts)")
        filteredContacts = contacts.contacts.filter { searchText.isEmpty || $0.username.localizedCaseInsensitiveContains(searchText) }
            print(searchText)
            print("🔍 Filtered contacts updated: \(filteredContacts)") // Debugging
        }
    
    func getContacts () {
        isLoading.toggle()
        
        
        contacts = ContactsResponse(contacts: [ChatApp.Contact(username: "Loxzer", message: Optional("Hola")), ChatApp.Contact(username: "Santiago Gordon", message: nil), ChatApp.Contact(username: "Eadie Miranda", message: Optional("D")), ChatApp.Contact(username: "Adiel MS", message: Optional("Hi")), ChatApp.Contact(username: "Marielena", message: Optional("Hq")), ChatApp.Contact(username: "qwerty", message: Optional("Who are you?")), ChatApp.Contact(username: "Emaan Chester", message: nil), ChatApp.Contact(username: "Saul", message: Optional("Klk")), ChatApp.Contact(username: "Randy", message: Optional("Como la encontraste?")), ChatApp.Contact(username: "Alexie Donnelly", message: nil), ChatApp.Contact(username: "Eliezer", message: Optional("Hola")), ChatApp.Contact(username: "Dan", message: Optional("Hello")), ChatApp.Contact(username: "Elias", message: nil), ChatApp.Contact(username: "Clara RIce", message: Optional("Hey, how is it going?")), ChatApp.Contact(username: "mohan", message: Optional("Hi")), ChatApp.Contact(username: "Marlon Coates", message: Optional("Hello")), ChatApp.Contact(username: "Matthias", message: Optional("No")), ChatApp.Contact(username: "ramonmateo", message: nil), ChatApp.Contact(username: "Robert", message: Optional("Very good indeed")), ChatApp.Contact(username: "Ledesma", message: Optional("Weyyyy")), ChatApp.Contact(username: "Jose", message: nil), ChatApp.Contact(username: "Jazer", message: nil), ChatApp.Contact(username: "sabrina", message: Optional(":)!")), ChatApp.Contact(username: "brom", message: nil), ChatApp.Contact(username: "elpepe", message: Optional(".")), ChatApp.Contact(username: "EduardoOller", message: Optional("Hello")), ChatApp.Contact(username: "Uridis", message: Optional("Hello")), ChatApp.Contact(username: "Jhoneudy", message: Optional("Hola!")), ChatApp.Contact(username: "google", message: Optional("Who are you?")), ChatApp.Contact(username: "google1", message: Optional("Hello")), ChatApp.Contact(username: "vitu", message: Optional("Who are you?")), ChatApp.Contact(username: "google12", message: Optional("Who are you?")), ChatApp.Contact(username: "test", message: Optional("Who are you?")), ChatApp.Contact(username: "test", message: Optional("Who are you?")), ChatApp.Contact(username: "Bob", message: Optional("Hello")), ChatApp.Contact(username: "Fede", message: Optional("Hello")), ChatApp.Contact(username: "Alex Paul", message: nil), ChatApp.Contact(username: "Pedro", message: nil), ChatApp.Contact(username: "Maria", message: nil), ChatApp.Contact(username: "Hhhhh", message: nil)], user: "Christopher")
        isLoading = false
//        Task {
//            do{
//                if let response = try? await NetworkManager.shared.getContacts() {
//                 contacts = response
//                    isLoading.toggle()
//                }
//            }
//        }
    }
    
    
    
}

