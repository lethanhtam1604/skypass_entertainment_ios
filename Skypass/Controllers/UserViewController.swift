//
//  UserViewController.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/6/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class UserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let userView = UserView()
    
    var event:Event!
    var user: User!

    override func loadView() {
        view = userView
        view.setNeedsUpdateConstraints()
    }
    
    override func viewDidLoad() {
        title = "User"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        //enable swipe back when it changed leftBarButtonItem
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        userView.infoTable.delegate = self
        userView.infoTable.dataSource = self
        
        userView.questionTable.delegate = self
        userView.questionTable.dataSource = self

        userView.infoTable.reloadData()
        userView.questionTable.reloadData()
        
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        userView.constraintInfoHeight?.constant = ip6(90) * CGFloat(event.fields.activeCount)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height = ip6(25) + userView.infoTable.contentSize.height + userView.questionTable.contentSize.height

        userView.containerView.frame = CGRect(0, 0, view.frame.width, height)
        userView.scrollView.contentSize = userView.containerView.bounds.size
    }
    
    // tableview
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == userView.infoTable {
            return FieldType.count
        }
        return user.questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == userView.infoTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FieldTableViewCell
            let type = FieldType(rawValue: indexPath.row)!
            cell.user = user
            cell.fieldType = type
            cell.isHidden = !event.fields.isActive(type)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! QuestionTableViewCell
        cell.question = user.questions[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == userView.infoTable {
            return event.fields.isActive(FieldType(rawValue: indexPath.row)!) ? ip6(90) : 0
        }
        return ip6(450)
    }
}
