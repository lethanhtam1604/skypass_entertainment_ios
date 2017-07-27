//
//  Question.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/6/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import Firebase

class Question: NSObject {
    var id: String!
    var desc: String?
    var answer: String?
    
    convenience init(_ snapshot: FIRDataSnapshot) {
        self.init()
        id = snapshot.key
        if let value = snapshot.value as? [String:Any] {
            desc = value["title"] as? String
            answer = value["answer"] as? String
        }
    }
    
    func toAny() -> Any {
        let result:[String:Any?] = ["title": desc, "answer": answer]
        return result
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let rhs = object as? Question {
            return id == rhs.id
        }
        return false
    }
}
