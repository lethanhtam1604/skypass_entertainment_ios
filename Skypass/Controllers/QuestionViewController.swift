
//
//  QuestionViewController.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/5/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import TSMessages

class QuestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    let questionView = QuestionView()

    var applying = false
    var user: User!
    var event:Event! {
        didSet {
            questionView.tableView.reloadData()
        }
    }
    
    override func loadView() {
        view = questionView
        view.setNeedsUpdateConstraints()
    }
    
    override func viewDidLoad() {
        title = "Sign Up"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(save))
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white

        questionView.tableView.delegate = self
        questionView.tableView.dataSource = self
        questionView.tableView.emptyDataSetSource = self
        questionView.tableView.emptyDataSetDelegate = self
        questionView.tableView.reloadData()
        
        //enable swipe back when it changed leftBarButtonItem
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    func save() {
        if applying {
            return
        }

        
        for i in 0..<event.questions.count {
            let cell = questionView.tableView.cellForRow(at: IndexPath(row: i, section: 0)) as! QuestionTableViewCell
            if cell.textView.text.isEmpty {
                alert(message: "Enter your answer for question: \(event.questions[i].desc!)", title: "Error")
                return
            }
            cell.question.answer = cell.textView.text
        }

        user.questions.removeAll()
        user.questions.append(contentsOf: event.questions)

        applying = true
        DatabaseHelper.shared.apply(user: user, event: event) {
            self.applying = false
            _ = self.navigationController?.popToRootViewController(animated: true)
            
            TSMessage.showNotification(withTitle: "Your information has been applied", type: .success)
        }
    }
    
    
    // tableview
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return event.questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! QuestionTableViewCell
        cell.question = event.questions[indexPath.row]
        return cell
    }
    
    // empty set
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attrs = [NSForegroundColorAttributeName: Global.colorPrimary.alpha(0.5),
                     NSFontAttributeName: Global.font(20)]
        return NSAttributedString(string: "No question found", attributes: attrs)
    }
}
