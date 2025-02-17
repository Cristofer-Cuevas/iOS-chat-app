//
//  GnialCard.swift
//  ChatApp
//
//  Created by GNIAL App on 1/2/25.
//

import SwiftUI

struct GnialCard: View {
    
    
    @State var isFlipped: Bool = false
    
    var body: some View {
        
        
        
        ZStack {
            Card(imageName: "gnialBackCard", isTrue: 0, isFalse: -90, isFlipped: $isFlipped)
                .animation(isFlipped ? .linear.delay(0.35) : .linear, value: isFlipped)
            
            
            
            
            Card(imageName: "gnialCard", isTrue: 90, isFalse: 0, isFlipped: $isFlipped)
                .animation(isFlipped ? .linear : .linear.delay(0.35), value: isFlipped)
            
            
            
            
        }
        
    }
}



struct Card: View {
    let imageName: String
    let isTrue: CGFloat
    let isFalse: CGFloat
    @Binding var isFlipped: Bool
    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
            //                .scaledToFit()
        } .overlay(Button {
            
            isFlipped.toggle()
            
            
            
        } label: {
            ZStack {
                
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.orange)
                //                    .opacity(0.6)
                
                Image(systemName: isFlipped ? "arrowshape.forward.fill" : "info")
                //                    .imageScale(.small)
                    .frame(width: 54, height: 54)
                    .foregroundColor(.black)
                
                
            } .padding(.horizontal, -20)
                .padding(.vertical, -20)
        }, alignment: .topTrailing)
        .onTapGesture {
            withAnimation (.easeIn(duration: 10)) {
                
                isFlipped.toggle()
                
            }
        }
        
        .frame(width: 250, height: 150)
        .rotation3DEffect(
            .degrees(isFlipped ? isTrue : isFalse),
            axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
        )
    }
}


#Preview {
    GnialCard()
}
