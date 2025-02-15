//
//  FilterModel.swift
//  ChatApp
//
//  Created by GNIAL App on 9/2/25.
//

import Foundation

enum FilterModel: Int, CaseIterable {
    
    case all
    case online
    case offline
    
    var option: String {
        switch self {
        case .all:
            return "All"
        case .online:
            return "Online"
        case .offline:
            return   "Offline"
        }
    }
    
    
}

extension FilterModel: Identifiable {
    var id: Int {return self.rawValue}
}
