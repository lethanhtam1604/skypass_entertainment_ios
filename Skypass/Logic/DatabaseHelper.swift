//
//  DatabaseHelper.swift
//  Ricochet
//
//  Created by Luu Nguyen on 12/24/16.
//  Copyright © 2016 Lavamy. All rights reserved.
//

import Firebase

class DatabaseHelper: NSObject {
    static let shared = DatabaseHelper()
    
    private let databaseRef = FIRDatabase.database().reference()
    private let storageRef = FIRStorage.storage().reference()
    private let localStorage = UserDefaults.standard
    
    func getEvents(completion: @escaping ([Event]) -> Void) {
        let ref = self.databaseRef.child("events")
        ref.observeSingleEvent(of: .value, with: { snapshot in
            if let data = snapshot.children.allObjects as? [FIRDataSnapshot] {
                var result = [Event]()
                for snap in data {
                    let event = Event(snap)
                    if !event.end {
                        result.append(event)
                    } else {
                        if event.end { self.removeAppliedEvent(event.id) }
                    }
                }
                completion(result)
            } else {
                completion([])
            }
        })
    }
    
    func observeEvents(completion: @escaping (Event) -> Void) {
        let ref = self.databaseRef.child("events")
        
        ref.observe(.childChanged, with: { snapshot in
            let event = Event(snapshot)
            if event.end { self.removeAppliedEvent(event.id) }
            completion(event)
        })
        
        ref.observe(.childAdded, with: { snapshot in
            let event = Event(snapshot)
            completion(event)
        })
    }

    func apply(user: User, event: Event, completion: @escaping () -> Void) {
        let eventRef = self.databaseRef.child("event_users").child(event.id).childByAutoId()
        eventRef.setValue(user.toAny())

        eventRef.observeSingleEvent(of: .value, with: { _ in
            self.addAppliedEvent(event.id)
            completion()
        })
    }
    
    func getAppliedEvents() -> [String] {
        return localStorage.array(forKey: "eventIds") as? [String] ?? [String]()
    }
    
    private func addAppliedEvent(_ id: String) {
        var eventIds = self.localStorage.array(forKey: "eventIds") as? [String] ?? [String]()
        eventIds.append(id)
        self.localStorage.set(eventIds, forKey: "eventIds")
        self.localStorage.synchronize()
    }
    
    private func removeAppliedEvent(_ id: String) {
        var eventIds = self.localStorage.array(forKey: "eventIds") as? [String] ?? [String]()
        eventIds.remove(id)
        self.localStorage.set(eventIds, forKey: "eventIds")
        self.localStorage.synchronize()
    }
    
    func end(event: Event, completion: @escaping () -> Void) {
        let eventRef = self.databaseRef.child("events").child(event.id).child("end")
        eventRef.setValue(true)
        
        eventRef.observeSingleEvent(of: .value, with: { _ in
            event.end = true
            completion()
        })
    }
    
    
    func getUsers(for event: Event, completion: @escaping ([User]) -> Void) {
//        let ref = self.databaseRef.child("event_users").queryOrderedByKey().queryEqual(toValue: event.id)
//        ref.observe(.value, with: { snapshot in
//            if let data = snapshot.children.allObjects as? [FIRDataSnapshot] {
//                var result = [User]()
//                for snap in data {
//                    if let userSnap = snap.children.allObjects.first as? FIRDataSnapshot {
//                        let user = User(userSnap)
//                        result.append(user)
//                    }
//                }
//                completion(result)
//            } else {
//                completion([])
//            }
//        })
        
        self.databaseRef.child("event_users").child(event.id).observe(.value, with: { snapshot in
            if let data = snapshot.children.allObjects as? [FIRDataSnapshot] {
                var result = [User]()
                for snap in data {
//                    let user = User(snapshot: item as! FIRDataSnapshot)
                    let user = User(snap)

//                    if let userSnap = snap.children.allObjects.first as? FIRDataSnapshot {
//                        let user = User(userSnap)
                        result.append(user)
//                    }
                }
//                for item in snapshot.children {
//                    let user = User(snapshot: item as! FIRDataSnapshot)
//                    if user.email == self.mailField.text {
//                        if user.type == 1 {
//                            UserDefaultManager.getInstance().setUserType(value: true)
//                        }
//                        else {
//                            UserDefaultManager.getInstance().setUserType(value: false)
//                        }
//                        
//                        let viewController = MainViewController()
//                        self.present(viewController, animated: true, completion: nil)
//                        break
//                    }
//                }

                completion(result)
            }
            else {
                completion([])
            }
            
        })
        
//        ref.observeSingleEvent(of: .value, with: { snapshot in
//            if let data = snapshot.children.allObjects as? [FIRDataSnapshot] {
//                var result = [User]()
//                for snap in data {
//                    if let userSnap = snap.children.allObjects.first as? FIRDataSnapshot {
//                        let user = User(userSnap)
//                        result.append(user)
//                    }
//                }
//                completion(result)
//            } else {
//                completion([])
//            }
//        })
    }
    
    func save(event: Event, completion: @escaping () -> Void) {
        uploadImage(for: event) { _ in
            var ref = self.databaseRef.child("events")
            
            if event.id.isEmpty {
                ref = ref.childByAutoId()
            } else {
                ref = ref.child(event.id)
            }
            
            ref.setValue(event.toAny())
            ref.observeSingleEvent(of: .value, with: { _ in
                completion()
            })
        }
    }
    
    
    private func uploadImage(for event: Event, completion: @escaping (String?) -> Void) {
        if let image = event.localImage {
            let data = UIImagePNGRepresentation(image.resize(CGSize(300, 300)))!
            let metadata = FIRStorageMetadata()
            metadata.contentType = "image/png"

            let ref = storageRef.child("\(UUID().uuidString).png")
            ref.put(data, metadata: metadata) {
                (metadata, error) in
                guard let metadata = metadata else {
                    completion(error!.localizedDescription)
                    return
                }
                event.image = metadata.downloadURL()!.absoluteString
                event.localImage = nil
                completion(nil)
            }
        } else {
            completion(nil)
        }
    }
}
