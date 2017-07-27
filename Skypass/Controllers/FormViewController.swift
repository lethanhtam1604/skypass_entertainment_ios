//
//  FormViewController.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/5/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit

class FormViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let formView = FormView()
    
    var event:Event! {
        didSet {
            formView.tableView.reloadData()
        }
    }
    
    override func loadView() {
        view = formView
        view.setNeedsUpdateConstraints()
    }
    
    override func viewDidLoad() {
        title = "Sign Up"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(nextStep))
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        //enable swipe back when it changed leftBarButtonItem
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white

        formView.tableView.delegate = self
        formView.tableView.dataSource = self
        formView.tableView.reloadData()
        
        formView.activeLabel.handleCustomTap(for: formView.customType) {
            _ in
            self.disclaimer()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        view.endEditing(true)
    }
    
    func disclaimer() {
        let disclaimerVC = DisclaimerViewController()
        disclaimerVC.event = event
        navigationController?.pushViewController(disclaimerVC, animated: true)
    }
    
    func nextStep() {
        // verify information
        
        let user = User()
        
        for i in 0..<FieldType.count {
            let cell = formView.tableView.cellForRow(at: IndexPath(row: i, section: 0)) as! FieldTableViewCell

            if !event.fields.isActive(cell.fieldType) {
                continue
            }
            
            switch cell.fieldType! {
            case .name:
                if cell.textField.text?.isEmpty ?? true {
                    alert(message: "Name cannot be empty", title: "Error")
                    return
                }
                user.name = cell.textField.text
                
            case .email:
                if !(cell.textField.text?.isValidEmail() ?? false) {
                    alert(message: "Email address is invalid", title: "Error")
                    return
                }
                user.email = cell.textField.text

            case .gender:
                if cell.textField.text?.isEmpty ?? true {
                    alert(message: "Gender cannot be empty", title: "Error")
                    return
                }
                user.gender = cell.textField.text
                
            case .birthday:
                if cell.textField.text?.isEmpty ?? true {
                    alert(message: "Birthday cannot be empty", title: "Error")
                    return
                }
                user.birthday = cell.textField.text?.date
                
            case .phone:
                if !(cell.textField.text?.isValidPhone() ?? false) {
                    alert(message: "Phone number is invalid", title: "Error")
                    return
                }
                user.phone = cell.textField.text
                
            case .location:
                if cell.textField.text?.isEmpty ?? true {
                    alert(message: "Location cannot be empty", title: "Error")
                    return
                }
                user.location = cell.textField.text
                
                
            case .zipcode:
                if cell.textField.text?.isEmpty ?? true {
                    alert(message: "Zip Code cannot be empty", title: "Error")
                    return
                }
                user.zipcode = cell.textField.text
            }
        }
        
        if formView.checkBox.checkState != .checked {
            alert(message: "You need to agree to disclaimer in order to apply to this event", title: "Error")
            return
        }
        
        let questionVC = QuestionViewController()
        questionVC.event = event
        questionVC.user = user
        navigationController?.pushViewController(questionVC, animated: true)
    }
    
    
    // tableview
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FieldType.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return event.fields.isActive(FieldType(rawValue: indexPath.row)!) ? ip6(130) : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FieldTableViewCell(style: .default, reuseIdentifier: "\(indexPath.row)")
        cell.user = nil
        cell.fieldType = FieldType(rawValue: indexPath.row)!
        cell.isHidden = !event.fields.isActive(FieldType(rawValue: indexPath.row)!)
        return cell
    }
}
