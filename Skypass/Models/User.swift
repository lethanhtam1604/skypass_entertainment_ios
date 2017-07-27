//
//  User.swift
//  Ricochet
//
//  Created by Luu Nguyen on 12/11/16.
//  Copyright © 2016 Lavamy. All rights reserved.
//

import Firebase

class User: NSObject {
    var id: String = ""
    var name: String?
    var email: String?
    var gender: String?
    var birthday: Date?
    var phone: String?
    var location: String?
    var zipcode: String?
    var questions = [Question]()
    
    convenience init(_ snapshot: FIRDataSnapshot) {
        self.init()
        id = snapshot.key
        if let value = snapshot.value as? [String:Any] {
            name = value["name"] as? String
            email = value["email"] as? String
            gender = value["gender"] as? String
            birthday = (value["birthday"] as? String)?.date
            phone = value["phone"] as? String
            location = value["location"] as? String
            zipcode = value["zipcode"] as? String
            
            let questionSnapshot = snapshot.childSnapshot(forPath: "questions")
            if let questions = questionSnapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in questions {
                    self.questions.append(Question(snap))
                }
            }
        }
    }
    
    func toAny() -> Any {
        var questionArray = [Any]()
        
        for question in questions {
            questionArray.append(question.toAny())
        }
        
        let result:[String:Any?] = ["name": name,
                                    "email": email,
                                    "gender": gender,
                                    "birthday": birthday?.dateString,
                                    "phone": phone,
                                    "location": location,
                                    "zipcode": zipcode,
                                    "questions": questionArray]
        return result
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let rhs = object as? User {
            return id == rhs.id
        }
        return false
    }
}
