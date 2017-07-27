//
//  Location.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/5/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import Firebase

class Location: NSObject {
    var id: String!
    var location: String?
    var desc: String?
    var date: Date?
    var time: Date?
    var fullAddress: String?
    
    var datetime: Date? {
        get {
            if date == nil {
                return nil
            }
            
            if time == nil {
                return date
            }
            
            let calendar = Calendar.current
            var components = DateComponents()
            components.day = calendar.component(.day, from: date!)
            components.month = calendar.component(.month, from: date!)
            components.year = calendar.component(.year, from: date!)
            components.hour = calendar.component(.hour, from: time!)
            components.minute = calendar.component(.minute, from: time!)
            components.second = calendar.component(.second, from: time!)

            return calendar.date(from: components)
        }
    }
    
    convenience init(_ snapshot: FIRDataSnapshot) {
        self.init()
        id = snapshot.key
        if let value = snapshot.value as? [String:Any] {
            location = value["place"] as? String
            desc = value["location"] as? String
            date = (value["date"] as? String)?.date
            time = (value["time"] as? String)?.date
        }
    }
    
    func toAny() -> Any {
        let result:[String:Any?] = ["place": location,
                                    "location": desc,
                                    "date": date?.dateString,
                                    "time": time?.timeString]
        return result
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let rhs = object as? Location {
            return id == rhs.id
        }
        return false
    }
}
