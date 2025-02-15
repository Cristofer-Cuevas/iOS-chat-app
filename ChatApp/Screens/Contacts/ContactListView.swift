//
//  ContactListView.swift
//  ChatApp
//
//  Created by GNIAL App on 2/2/25.
//

import SwiftUI

struct ContactListView: View {
    @State var isMenuOpen: Bool
    @Binding var path: [String]
    @Bindable var viewModel: ContactsListViewModel
    
    
    var body: some View {
        ZStack {
            SignOutView(isMenuOpen: $isMenuOpen, isSignOut: false, path: $path)
                .zIndex(2)
            
            VStack {
                
                VStack {
                    SearchView(isMenuOpen: $isMenuOpen, viewModel: viewModel)
                    
                    
                }
                
                VStack {
                    FilterView(selectedItem: .all)
                }
                .padding()
                
                Text("Contacts")
                    .font(.title)
                    .fontWeight(.heavy)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 30, alignment: .leading)
                    .padding(.leading, 10)
                
                
                VStack {
                    
                    if viewModel.isLoading {
                        Loader()
                    } else {
                        
                        List(viewModel.filteredContacts, id: \.self) { contact in
                            ContactListCell(contact: contact)
                                .listRowSeparator(.hidden)
                        }
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity,minHeight: 0,maxHeight: .infinity)
                
                
                
            }
        }
        
        .navigationBarHidden(true)
        .listStyle(.plain)
        //        .ignoresSafeArea()
        .onAppear{
            viewModel.getContacts()
        } .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EmptyView() // Hides the default back button
            }
        }
        .frame(alignment: .top)
    }
}

#Preview {
    ContactListView(isMenuOpen: false, path: .constant(["ContactList"]), viewModel: ContactsListViewModel(contacts: ContactsResponse(contacts: [], user: ""), isLoading: false, searchText: ""))
}
