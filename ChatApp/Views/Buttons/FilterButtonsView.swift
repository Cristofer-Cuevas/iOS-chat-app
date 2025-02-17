//
//  FilterButtonsView.swift
//  ChatApp
//
//  Created by GNIAL App on 9/2/25.
//

import SwiftUI

struct FilterButtonsView: View {
    let option: FilterModel
    @Binding var selectedOption: FilterModel
    var body: some View {
        
        
        Text(option.option)
            .frame(width: 100, height: 50)
            .background(option == selectedOption ? Color("textFieldColor") : Color.clear)
            .fontWeight(option == selectedOption ? .bold : .medium)
            .foregroundColor(option == selectedOption ? Color("buttonColor") : Color.black.opacity(0.3))
            .cornerRadius(40.0)
//        Button (action: {
////            print(selectedItem)
////            print(option)
//        }, label: {
//            
//        })
    }
}

#Preview {
    FilterButtonsView(option: .all, selectedOption: .constant(.all))
}
