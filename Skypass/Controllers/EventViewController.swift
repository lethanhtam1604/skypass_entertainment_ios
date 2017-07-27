//
//  EventViewController.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/5/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import TSMessages
import MessageUI

class EventViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, AlertDelegate, MFMailComposeViewControllerDelegate {
    let eventView = EventView()
    var ending = false
    
    var event:Event! {
        didSet {
            eventView.titleLabel.text = event.title
            eventView.infoLabel.text = event.info
            eventView.imageView.sd_setImage(with: URL(unsafeString: event.image))
            eventView.tableView.reloadData()
            
            let ids = DatabaseHelper.shared.getAppliedEvents()
            if ids.contains(event.id) {
                eventView.applyButton.isUserInteractionEnabled = false
                eventView.applyButton.setTitle("Applied", for: .normal)
            } else {
                eventView.applyButton.isUserInteractionEnabled = true
                eventView.applyButton.setTitle("Sign Up", for: .normal)
            }
            
            if event.end {
                eventView.endButton.setTitle("Ended", for: .normal)
                eventView.endButton.isUserInteractionEnabled = false
            } else {
                eventView.endButton.setTitle("End", for: .normal)
                eventView.endButton.isUserInteractionEnabled = true
            }
        }
    }
    
    override func loadView() {
        view = eventView
        view.setNeedsUpdateConstraints()
    }
    
    override func viewDidLoad() {
        title = "Event Details"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        //enable swipe back when it changed leftBarButtonItem
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        eventView.infoLabel.isUserInteractionEnabled = true
        eventView.infoLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(more)))
        eventView.moreButton.addTarget(self, action: #selector(more), for: .touchUpInside)
        eventView.applyButton.addTarget(self, action: #selector(apply), for: .touchUpInside)
        eventView.endButton.addTarget(self, action: #selector(end), for: .touchUpInside)
        eventView.userButton.addTarget(self, action: #selector(user), for: .touchUpInside)
        
        eventView.tableView.delegate = self
        eventView.tableView.dataSource = self
        eventView.tableView.emptyDataSetSource = self
        eventView.tableView.emptyDataSetDelegate = self
        eventView.tableView.reloadData()
        
        #if Admin
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit",
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(edit))
            
            navigationItem.leftBarButtonItem?.tintColor = UIColor.white
            navigationItem.rightBarButtonItem?.tintColor = UIColor.white
            
            eventView.applyButton.isHidden = true
            eventView.endButton.isHidden = false
            eventView.userButton.isHidden = false
            
        #else
            eventView.applyButton.isHidden = false
            eventView.endButton.isHidden = true
            eventView.userButton.isHidden = true
        #endif
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height = ip6(25 + 100 + 25  + 20 + 90 + 20 + 60) + view.frame.width * 0.4 * 1.4 + eventView.tableView.contentSize.height
        
        eventView.containerView.frame = CGRect(0, 0, view.frame.width, height)
        eventView.scrollView.contentSize = eventView.containerView.bounds.size
    }
    
    func more() {
        let detailVC = EventDetailViewController()
        detailVC.event = event
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func apply() {
        let formVC = FormViewController()
        formVC.event = event
        navigationController?.pushViewController(formVC, animated: true)
    }
    
    var random = 0
    
    func end() {
        if ending {
            return
        }
        ending = true
        
        DatabaseHelper.shared.getUsers(for: event) {
            users in
            self.users = users
            
            self.random = Int(arc4random_uniform(UInt32(users.count)))
            if self.random < users.count {
                Global.showAlertAction(title: "WINNER", message: users[self.random].name! + " is the winner of the event.", viewController: self, alertDelegate: self)
            }
            else {
                _ = self.navigationController?.popViewController(animated: true)
                TSMessage.showNotification(withTitle: "Event has been marked as ended", type: .success)
            }
        }
        
        DatabaseHelper.shared.end(event: self.event) {
            self.ending = false
        }
    }
    
    var users = [User]()
    
    func okAlertActionClicked() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([users[self.random].email ?? ""])
            mail.setSubject("EVENT WINNER")
            mail.setMessageBody(users[self.random].name! + " is the winner of the event.", isHTML: false)
            mail.navigationBar.isTranslucent = false
            mail.navigationBar.barTintColor = UIColor.red
            mail.navigationBar.tintColor = Global.colorPrimary
            self.present(mail, animated: true, completion: nil)
        }
        else {
            Global.showAlert(title: "Error", message: "You are not logged in email .Please check email configuration and try again", viewController: self)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }

    
    func user() {
        let userListVC = UserListViewController()
        userListVC.event = event
        navigationController?.pushViewController(userListVC, animated: true)
    }
    
    func edit() {
        let newEventVC = NewEventViewController()
        newEventVC.event = Event(event: event)
        navigationController?.pushViewController(newEventVC, animated: true)
    }
    
    // tableview
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return event.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EventLocationTableViewCell
        cell.location = event.locations[indexPath.row]
        return cell
    }
    
    // empty set
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attrs = [NSForegroundColorAttributeName: Global.colorPrimary.alpha(0.5),
                     NSFontAttributeName: Global.font(20)]
        return NSAttributedString(string: "No location found", attributes: attrs)
    }
}
