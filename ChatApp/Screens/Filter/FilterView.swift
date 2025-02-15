//
//  FilterView.swift
//  ChatApp
//
//  Created by GNIAL App on 9/2/25.
//

import SwiftUI

struct FilterView: View {
    
    @State var selectedItem: FilterModel
    
    var body: some View {
        
        HStack {
            ForEach(FilterModel.allCases) { option in
                FilterButtonsView(option: option, selectedItem: $selectedItem)
                    .onTapGesture {
                        selectedItem = option
                        
                    }
                
                
            }
            
        }
    }
}

#Preview {
    FilterView(selectedItem: .all)
}
