//
//  NewLocationViewController.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/14/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit

class NewLocationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let locationView = NewLocationView()
    
    var event:Event!
    
    var location:Location? {
        didSet {
            locationView.tableView.reloadData()
        }
    }
    
    override func loadView() {
        view = locationView
        view.setNeedsUpdateConstraints()
    }
    
    override func viewDidLoad() {
        title = "Location"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(save))
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        locationView.tableView.delegate = self
        locationView.tableView.dataSource = self
        locationView.tableView.reloadData()
        
        //enable swipe back when it changed leftBarButtonItem
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    func save() {
        // verify information
        
        let location = Location()
        
        for i in 0..<4 {
            let cell = locationView.tableView.cellForRow(at: IndexPath(row: i, section: 0)) as! LocationTableViewCell
            
            switch cell.order {
            case 0:
                if cell.textField.text?.isEmpty ?? true {
                    alert(message: "Venue cannot be empty", title: "Error")
                    return
                }
                location.location = cell.textField.text
                
            case 1:
                if cell.textField.text?.isEmpty ?? true {
                    alert(message: "Location cannot be empty", title: "Error")
                    return
                }
                location.desc = cell.newLocation?.desc
                
            case 2:
                if cell.textField.text?.isEmpty ?? true {
                    alert(message: "Date cannot be empty", title: "Error")
                    return
                }
                location.date = cell.textField.text?.date
                
            case 3:
                if cell.textField.text?.isEmpty ?? true {
                    alert(message: "Time cannot be empty", title: "Error")
                    return
                }
                location.time = cell.textField.text?.date
            
            default:
                break
            }
        }
        
        if self.location == nil {
            location.id = UUID().uuidString
            event.locations.append(location)
        } else {
            self.location!.location = location.location
            self.location!.desc = location.desc
            self.location!.date = location.date
            self.location!.time = location.time
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    
        // tableview
    
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 4
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return ip6(130)
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LocationTableViewCell
            cell.location = location
            cell.order = indexPath.row
            return cell
        }
}
