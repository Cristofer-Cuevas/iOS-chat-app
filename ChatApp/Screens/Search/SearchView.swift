//
//  SearchView.swift
//  ChatApp
//
//  Created by GNIAL App on 3/2/25.
//

import SwiftUI

struct SearchView: View {
    
    
    @Binding var isMenuOpen: Bool
    
    @Bindable var viewModel = ContactsListViewModel(contacts: ContactsResponse(contacts: [], user: ""), isLoading: false, searchText: "")
    
    var body: some View {
        HStack {
            HStack {
                Image("searchIcon")
                    .padding(.leading, 17)
                
                ZStack {
                    
                    if viewModel.searchText.isEmpty {
                        Text("Search for people...")
                            .font(.system(size: 19))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .opacity(0.6)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    }
                    
                    
                    TextField("", text: $viewModel.searchText)
                        
                }
               
                
            }
            .frame(height: 64)
            .background(Color("textFieldColor"))
            .cornerRadius(5.0)
            
            
            VStack {
                Image("moreIcon")
                    .resizable()
                    .onTapGesture {
                        isMenuOpen.toggle()
                    }
            }
            .frame(width: 40, height: 40)
            .opacity(0.3)
        }.padding()
    }
}

#Preview {
    SearchView(isMenuOpen: .constant(false))
}
