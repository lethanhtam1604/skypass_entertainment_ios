//
//  FieldType.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/5/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

enum FieldType: Int {
    case name = 0
    case email = 1
    case gender = 2
    case birthday = 3
    case phone = 4
    case location = 5
    case zipcode = 6
    
    static let count: Int = {
        var max: Int = 0
        while let _ = FieldType(rawValue: max) { max += 1 }
        return max
    }()
    
    
    func toString() -> String {
        switch self {
        case .name:
            return "Name"
        case .email:
            return "Email"
        case .gender:
            return "Gender"
        case .birthday:
            return "Birthday"
        case .phone:
            return "Phone"
        case .location:
            return "Location"
        case .zipcode:
            return "Zip Code"
        }
    }
}
