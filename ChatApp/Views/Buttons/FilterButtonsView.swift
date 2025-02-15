//
//  FilterButtonsView.swift
//  ChatApp
//
//  Created by GNIAL App on 9/2/25.
//

import SwiftUI

struct FilterButtonsView: View {
    let option: FilterModel
    @Binding var selectedItem: FilterModel
    var body: some View {
        
        
        Text(option.option)
            .frame(width: 100, height: 50)
            .background(option == selectedItem ? Color("textFieldColor") : Color.clear)
            .fontWeight(option == selectedItem ? .bold : .medium)
            .foregroundColor(option == selectedItem ? Color("buttonColor") : Color.black.opacity(0.3))
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
    FilterButtonsView(option: .all, selectedItem: .constant(.all))
}
