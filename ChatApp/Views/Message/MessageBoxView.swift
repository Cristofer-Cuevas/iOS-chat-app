//
//  MessageView.swift
//  ChatApp
//
//  Created by GNIAL App on 18/2/25.
//

import SwiftUI

struct MessageBoxView: View {
    @Binding var messages: MessageResponse
    @State private var keyboardHeight: CGFloat = 0
    
    var body: some View {
        VStack {
            ScrollViewReader {proxy in
                ScrollView {
                    VStack (){
                        ForEach(messages.messages, id: \._id) { message in
                            if message.sender == messages.requester {
                                //                                Spacer()
                                MessageView(message: message, isRequester: true)
                                //                                    .listRowSpacing(1150)
                                    .id(message._id)
                                    .listRowSeparator(.hidden)
                                //                            .onAppear{
                                //                                print("requester")
                                //                                print(message)
                                //                            }
                                
                            } else {
                                MessageView(message: message, isRequester: false)
                                //                                    .listRowSpacing(1150)
                                    .id(message._id)
                                    .listRowSeparator(.hidden)
                                //                                    .listRowSpacing(1150)
                                //                                    .background(.black)
                                //                                    .frame(width: 350, height: 10)
                                                                MessageView(message: message, isRequester: false)
                                //                                    .listRowSpacing(1150)
                                                                    .id(message._id)
                                                                    .listRowSeparator(.hidden)
                                //                                    .listRowSpacing(1150)
                            }
                            
                        }
                        
                        .scrollIndicators(.hidden)
                        
                    }
                }
                //            .padding(.bottom, keyboardHeight)
                
                
                .onAppear{
                    addKeyboardListeners()
                    if let lastMessage = messages.messages.last {
                        DispatchQueue.main.async {
                            proxy.scrollTo(lastMessage._id, anchor: .bottom)
                        }
                    }
                }
                .defaultScrollAnchor(.bottom)
                .listStyle(.plain)
                
            }
            //        .offset(y: -keyboardMananger.keyboardHeight)
        }
    }
    
    private func addKeyboardListeners() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
            if let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                keyboardHeight = frame.height
            }
        }

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
            keyboardHeight = 0
        }
    }
}



#Preview {
    MessageBoxView(messages:.constant( MessageResponse(messages: [Message(_id: "123", sender: "Random", recipient: "Random2", message: "Message", date: "14")], requester: "Random2")))
}
