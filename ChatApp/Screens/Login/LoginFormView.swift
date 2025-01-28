//
//  LoginFormView.swift
//  ChatApp
//
//  Created by GNIAL App on 25/1/25.
//

import SwiftUI

struct LoginFormView: View {
    @State var isSingup: Bool
    
    @Bindable var viewModel = LoginFormViewModel(username: "", password: "")
    
    var body: some View {
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
                if isSingup {
                    print("hello")
                    viewModel.signUp()
                } else {
                    print("helo2")
                    viewModel.getJWTToken()
                }
                
            }, label: {
                Text(isSingup ? "Sign up" : "Log in")
                    .font(.title3)
                    .fontWeight(.bold)
                
            }) .frame(minWidth: 0, maxWidth: .infinity, minHeight: 56)
                .background(Color("buttonColor"))
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
        }
        .padding(.horizontal, 20)
        .frame(height: 30)
        
    }
}

#Preview {
    LoginFormView(isSingup: false)
}
