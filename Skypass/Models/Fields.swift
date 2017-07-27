//
//  Fields.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/5/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import Firebase

class Fields: NSObject {
    var name = false
    var email = false
    var gender = true
    var birthday = true
    var phone = true
    var location = true
    var zipcode = true
    
    var activeCount: Int {
        get {
            var count = 0
            for i in 0..<FieldType.count {
                if let type = FieldType(rawValue: i) {
                    if isActive(type) { count += 1 }
                }
            }
            return count
        }
    }
    
    convenience init(fields: Fields) {
        self.init()
        name = fields.name
        email = fields.email
        gender = fields.gender
        birthday = fields.birthday
        phone = fields.phone
        location = fields.location
        zipcode = fields.zipcode
    }
    
    convenience init(_ snapshot: FIRDataSnapshot) {
        self.init()
        if let value = snapshot.value as? [String:Any] {
            name = value["name"] as? Bool ?? false
            email = value["email"] as? Bool ?? false
            gender = value["gender"] as? Bool ?? false
            birthday = value["birthday"] as? Bool ?? false
            phone = value["phone"] as? Bool ?? false
            location = value["location"] as? Bool ?? false
            zipcode = value["zipcode"] as? Bool ?? false
        }
    }
    
    func toAny() -> Any {
        
        let result:[String:Any?] = ["name": name,
                                    "email": email,
                                    "gender": gender,
                                    "birthday": birthday,
                                    "phone": phone,
                                    "location": location,
                                    "zipcode": zipcode]
        return result
    }
    
    func active( _ field: FieldType, active: Bool) {
        switch field {
        case .name:
            name = active
        case .email:
            email = active
        case .gender:
            gender = active
        case .birthday:
            birthday = active
        case .phone:
            phone = active
        case .location:
            location = active
        case .zipcode:
            zipcode = active
        }
    }
    
    func isActive(_ field: FieldType) -> Bool {
        switch field {
        case .name:
            return name
        case .email:
            return email
        case .gender:
            return gender
        case .birthday:
            return birthday
        case .phone:
            return phone
        case .location:
            return location
        case .zipcode:
            return zipcode
        }
    }
}
