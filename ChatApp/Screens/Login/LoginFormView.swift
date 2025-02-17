//
//  LoginFormView.swift
//  ChatApp
//
//  Created by GNIAL App on 25/1/25.
//

import SwiftUI

struct LoginFormView: View {
    @State var isSingup: Bool
    
    @Bindable var viewModel = LoginFormViewModel(username: "", password: "", alertItem: AlertContext.invalidCredentials, errorOccurred: false, isSignUpFailed: false, isLoginSuccessFul: false, isLoading: false, isValidatingSession: false)
    var contactsViewModel = ContactsListViewModel(contacts: ContactsResponse(contacts: [], user: ""), isLoading: false, searchText: "", selectedOption: .all)
    
//    @State var path: [String] = []
    
    var body: some View {
        NavigationStack (path: $viewModel.path) {
            
            if viewModel.isValidatingSession {
                RingLoaderView()
            } else {
                ZStack {
                    if viewModel.isLoading {
                        RingLoaderView()
                            .zIndex(2)
                    }
                    VStack(alignment: .center, spacing: 16) {
                        Text(isSingup ? "Sign up" : "Log in")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
                        HStack {
                            Image("personFormImage")
                                .padding(.leading, 17)
                            TextField("Username", text: $viewModel.username)
                            
                            
                        }
                        .frame(height: 64)
                        .background(Color("textFieldColor"))
                        .cornerRadius(5.0)
                        
                        HStack {
                            Image("lockFormImage")
                                .padding(.leading, 17)
                            SecureField("Password", text: $viewModel.password)
                            
                        }
                        .frame(height: 64)
                        .background(Color("textFieldColor"))
                        .cornerRadius(5.0)
                        
                        
                        
                        Button (action: {
                            print("path", viewModel.path)
                            if isSingup {
                                viewModel.signUp()
                            } else {
                                viewModel.getJWTToken()
                            }
                        }, label: {
                            Text(isSingup ? "Sign up" : "Log in")
                                .font(.title3)
                                .fontWeight(.bold)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 56)
                            
                        })  .background(Color("buttonColor"))
                            .foregroundColor(.white)
                            .cornerRadius(5.0)
                        
                        
                        HStack {
                            
                            Text(isSingup ? "Already have an account?" : "Don't have an account?")
                            Button (action: {
                                isSingup.toggle()
                            }, label: {
                                Text(isSingup ? "Log in" : "Sign up")
                                    .foregroundColor(Color("buttonColor"))
                            })
                            
                        }
                    }.navigationDestination(for: String.self) { screen in
                        
                        if "ContactList" == screen {
                            ContactListView(isMenuOpen: false, path: $viewModel.path, viewModel: contactsViewModel)
                        }
                    }.alert("Operation Failed", isPresented: $viewModel.errorOccurred) {
                        Button("OK", role: .cancel, action: { })
                        
                    } message: {
                        if viewModel.isSignUpFailed {
                            Text("Check the entered credentials. And try again.")
                        } else {
                            Text("The username or password you entered is incorrect. Please double-check and try again.")
                        }
                        
                    }
                    .padding(.horizontal, 20)
                    .frame(height: 30)
                    
                }
            }
        }.onAppear{
            viewModel.validateToken()
        }
    }
}

#Preview {
    LoginFormView(isSingup: false, contactsViewModel: ContactsListViewModel(contacts: ContactsResponse(contacts: [], user: ""), isLoading: false, searchText: "", selectedOption: .all))
}


//Christopher
