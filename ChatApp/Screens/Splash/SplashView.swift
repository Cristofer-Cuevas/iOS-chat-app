//
//  SplashView.swift
//  ChatApp
//
//  Created by GNIAL App on 11/2/25.
//

import SwiftUI

struct SplashView: View {
//    var tokenManager = TokenManager()
//    @State var redirect: String = ""
//    @Bindable var viewModel = LoginFormViewModel(username: "", password: "", alertItem: AlertContext.invalidCredentials, errorOccurred: false, isSignUpFailed: false, isLoginSuccessFul: false, isLoading: false)
//    var contactsViewModel = ContactsListViewModel(contacts: ContactsResponse(contacts: [], user: ""))   
    var body: some View {
        VStack {
            RingLoaderView()
            
        }
    }
}

#Preview {
    SplashView()
}
