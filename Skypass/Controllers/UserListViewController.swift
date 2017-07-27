//
//  UserListViewController.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/6/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import SwiftOverlays

class UserListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    let userListView = UserListView()
    
    var event:Event!
    var users = [User]()
    
    override func loadView() {
        view = userListView
        view.setNeedsUpdateConstraints()
    }
    
    override func viewDidLoad() {
        title = "Users"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        //enable swipe back when it changed leftBarButtonItem
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white

        userListView.tableView.delegate = self
        userListView.tableView.dataSource = self
        userListView.tableView.emptyDataSetSource = self
        userListView.tableView.emptyDataSetDelegate = self
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    func loadData() {
        userListView.indicator.startAnimating()
        DatabaseHelper.shared.getUsers(for: event) {
            users in
            
            // initialize
            
            self.users = users
            self.userListView.tableView.reloadData()
            self.userListView.indicator.stopAnimating()
            
            if self.users.count > 0 {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Export", style: .plain, target: self, action: #selector(self.export))
                self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
            }
        }
    }
    
    
    func export() {
        if users.isEmpty {
            alert(message: "No user found", title: "Error")
            return
        }

        // csv
        SwiftOverlays.showBlockingWaitOverlay()
        
        var headers = "Name, Email, Gender, Birthday, Phone, Location, Zipcode"
        for i in 0..<users.first!.questions.count {
            headers += ", Question \(i+1)"
            headers += ", Answer"
        }
        
        var rows = [headers]
        
        for user in users {
            
            var location = " "
            
            if user.location != nil || user.location == "" {
                location = (user.location?.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil))!
            }

            var row = String(format: "%@, %@, %@, %@, %@, %@, %@",
                             user.name ?? " ",
                             user.email ?? " ",
                             user.gender ?? " ",
                             user.birthday?.dateString ?? " ",
                             user.phone ?? " ",
                             location,
                             user.zipcode ?? " ")
            
            for question in user.questions {
                row += ",\(question.desc ?? "")"
                row += ",\(question.answer ?? "")"
            }
            
            rows.append(row)
        }

        var result = ""
        for row in rows {
            result += row + "\n"
        }
        
        // file share
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let filename = (path as NSString).appendingPathComponent("\(event.title)-users-\(Date().iso8601).csv")
        let fileURL = URL(fileURLWithPath: filename)
        try! result.write(to: fileURL, atomically: true, encoding: .utf8)
        let activityVC = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        SwiftOverlays.removeAllBlockingOverlays()
        self.present(activityVC, animated: true, completion: nil)
    }
    
    // tableview
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell
        cell.user = users[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        let userVC = UserViewController()
        userVC.event = event
        userVC.user = user
        navigationController?.pushViewController(userVC, animated: true)
    }
    
    // empty set
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attrs = [NSForegroundColorAttributeName: Global.colorPrimary.alpha(0.5),
                     NSFontAttributeName: Global.font(20)]
        return NSAttributedString(string: "No user found", attributes: attrs)
    }
}
