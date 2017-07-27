//
//  FilterType.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/5/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

enum FilterType: Int {
    case defaut = 0
    case name = 1
    case date = 2
    
    static let count: Int = {
        var max: Int = 0
        while let _ = FilterType(rawValue: max) { max += 1 }
        return max
    }()
    
    func toString() -> String {
        switch self {
        case .name:
            return "Name"
        case .date:
            return "Date"
        default:
            return "Default"
        }
    }
}
