//
//  SignOutView.swift
//  ChatApp
//
//  Created by GNIAL App on 3/2/25.
//

import SwiftUI

struct SignOutView: View {
    
    @Binding var isMenuOpen: Bool
    @State var isSignOut: Bool
    @Bindable var viewModel = LoginFormViewModel(username: "", password: "", alertItem: AlertContext.invalidCredentials, errorOccurred: false, isSignUpFailed: false, isLoginSuccessFul: false, isLoading: false, isValidatingSession: false)
    @Binding var path: [String]

    
    var body: some View {
        VStack {
            ZStack {
                
                if isMenuOpen {
                    Rectangle ()
                        .opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture{ isMenuOpen.toggle()}
                    HStack {
                        Spacer()
                        VStack (alignment: .center) {
                            
                            VStack {
                                
                                Image(systemName:"xmark")
                                
                                    .imageScale(.large)
                            }
                            .frame(width: 270, alignment: .trailing)
                            .padding(.trailing, 5)
                            .onTapGesture{
                                print(isMenuOpen)
                                isMenuOpen.toggle()
                            }
                            
                            Text("Logged in as:")
                                .font(.title2)
                                .padding()
                            Text("Christopher")
                                .fontWeight(.bold)
//                            Spacer()
                            
                            
                            
                            
                            Spacer()
                            Button(action: {
                                print(path)
                                path.removeLast(path.count)
                                print(path)
                            
                                viewModel.signOut()
                                isSignOut.toggle()
                            }, label: {
                                Text("Sign Out")
                                
                            })
                        }
                        .frame(width: 270)
                        .padding()
                        .background(.white)
                        
                        
                    }
                    .transition(.move(edge: .trailing))
                }
            }
            .animation(.easeInOut, value: isMenuOpen)
            
        }
    }
}

#Preview {
    SignOutView(isMenuOpen: .constant(true), isSignOut: false, path: .constant(["ContactList"]))
}



