//
//  FilterView.swift
//  ChatApp
//
//  Created by GNIAL App on 9/2/25.
//

import SwiftUI

struct FilterView: View {
    
    @Binding var selectedOption: FilterModel
    
    var body: some View {
        
        HStack {
            ForEach(FilterModel.allCases) { option in
                FilterButtonsView(option: option, selectedOption: $selectedOption)
                    .onTapGesture {
                        selectedOption = option
                        
                    }
                
                
            }
            
        }
    }
}

#Preview {
    FilterView(selectedOption: .constant(.all))
}
