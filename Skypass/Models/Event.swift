//
//  Event.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/5/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import Firebase

class Event: NSObject {
    var id: String = ""
    var title: String = ""
    var info: String?
    var image: String?
    var localImage: UIImage?
    var disclaimer: String?
    var end = false
    var priority:Int = 0
    
    var fields = Fields()
    var locations = [Location]()
    var questions = [Question]()
    
    convenience init(event: Event) {
        self.init()
        id = event.id
        title = event.title
        info = event.info
        image = event.image
        localImage = event.localImage
        disclaimer = event.disclaimer
        end = event.end
        priority = event.priority
        fields = Fields(fields: event.fields)
        locations = []
        questions = []
        
        locations.append(contentsOf: event.locations)
        questions.append(contentsOf: event.questions)
    }
    
    convenience init(_ snapshot: FIRDataSnapshot) {
        self.init()
        id = snapshot.key
        if let value = snapshot.value as? [String:Any] {
            title = value["name"] as? String ?? "No name event"
            image = value["image_url"] as? String
            info = value["description"] as? String
            disclaimer = value["disclaimer"] as? String
            end = value["end"] as? Bool ?? false
            priority = value["priority"] as? Int ?? 0
            
            let fieldSnapshot = snapshot.childSnapshot(forPath: "fields")
            if fieldSnapshot.exists() {
                fields = Fields(fieldSnapshot)
            }
            
            let locationSnapshot = snapshot.childSnapshot(forPath: "locations")
            if let locations = locationSnapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in locations {
                    let location = Location(snap)
                    self.locations.append(location)
                }
            }
            
            let questionSnapshot = snapshot.childSnapshot(forPath: "questions")
            if let questions = questionSnapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in questions {
                    let question = Question(snap)
                    self.questions.append(question)
                }
            }
        }
    }
    
    func toAny() -> Any {
        var locationArray = [Any]()
        var questionArray = [Any]()
        
        for location in locations {
            locationArray.append(location.toAny())
        }
        
        for question in questions {
            questionArray.append(question.toAny())
        }
        
        let result:[String:Any?] = ["name": title,
                "image_url": image,
                "description": info,
                "disclaimer": disclaimer,
                "end": end,
                "priority": priority,
                "fields": fields.toAny(),
                "locations": locationArray,
                "questions": questionArray]
        return result
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let rhs = object as? Event {
            return id == rhs.id
        }
        return false
    }
}
