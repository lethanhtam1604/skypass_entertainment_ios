//
//  NewEventViewController.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/6/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import TSMessages
import SwiftOverlays

class NewEventViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let newEventView = NewEventView()

    var isNew = false
    
    var saving = false
    var event = Event() {
        didSet {
            title = "Edit Event"
            
            newEventView.imageView.sd_setImage(with: URL(unsafeString: event.image))
            newEventView.titleText.text = event.title
            newEventView.infoText.text = event.info ?? ""
            newEventView.prioritySlider.value = Float(event.priority)
            newEventView.priorityValue.text = "\(event.priority)"
            
            newEventView.locationTable.reloadData()
            newEventView.questionTable.reloadData()
            newEventView.fieldTable.reloadData()
        }
    }
    
    override func loadView() {
        view = newEventView
        view.setNeedsUpdateConstraints()
    }
    
    override func viewDidLoad() {
        if title == nil {
            title = "New Event"
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(save))
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        //enable swipe back when it changed leftBarButtonItem
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white

        newEventView.uploadButton.addTarget(self, action: #selector(upload), for: .touchUpInside)
        newEventView.locationButton.addTarget(self, action: #selector(location), for: .touchUpInside)
        newEventView.questionButton.addTarget(self, action: #selector(question), for: .touchUpInside)
        newEventView.disclaimerButton.addTarget(self, action: #selector(disclaimer), for: .touchUpInside)
        newEventView.prioritySlider.addTarget(self, action: #selector(priority), for: .valueChanged)

        newEventView.locationTable.delegate = self
        newEventView.locationTable.dataSource = self
        newEventView.locationTable.emptyDataSetSource = self
        newEventView.locationTable.emptyDataSetDelegate = self
        
        newEventView.questionTable.delegate = self
        newEventView.questionTable.dataSource = self
        newEventView.questionTable.emptyDataSetSource = self
        newEventView.questionTable.emptyDataSetDelegate = self
        
        newEventView.fieldTable.delegate = self
        newEventView.fieldTable.dataSource = self
        newEventView.fieldTable.emptyDataSetSource = self
        newEventView.fieldTable.emptyDataSetDelegate = self

        newEventView.fieldTable.reloadData()

        newEventView.titleText.delegate = self
        newEventView.infoText.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        newEventView.locationTable.reloadData()
        newEventView.questionTable.reloadData()

        self.newEventView.setNeedsUpdateConstraints()
        self.newEventView.setNeedsLayout()
        self.newEventView.updateConstraintsIfNeeded()
        self.newEventView.layoutIfNeeded()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        newEventView.constraintQuestionHeight?.constant = CGFloat(max(event.questions.count, 1) * 44)
        newEventView.constraintLocationHeight?.constant = CGFloat(max(event.locations.count, 1) * 44)
        newEventView.constraintFieldHeight?.constant = CGFloat(max(FieldType.count, 1) * 44)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let imageHeight = UIScreen.main.bounds.width * 280 / 750 * 354 / 275
        let locationHeight = max(newEventView.locationTable.contentSize.height, 44)
        let questionHeight = max(newEventView.questionTable.contentSize.height, 44)
        let fieldHeight = newEventView.fieldTable.contentSize.height
        
        var height = ip6(25  + 18 + 52  + 50 + 30  + 25 + 180  + 30 + 30  + 25  + 30 + 30  + 25  + 80 + 90  + 166  + 40 + 30  + 22  + 190)
        height += imageHeight + locationHeight + questionHeight + fieldHeight

        newEventView.containerView.frame = CGRect(0, 0, view.frame.width, height)
        newEventView.scrollView.contentSize = newEventView.containerView.bounds.size
    }
    
    func save() {
        if saving {
            return
        }
        
        if  newEventView.imageView.image == nil {
            Global.showAlert(title: "Error", message: "Image can not be empty!", viewController: self)
            return
        }
        
        if  newEventView.titleText.text == "" {
            Global.showAlert(title: "Error", message: "Title can not be empty!", viewController: self)
            return
        }
        
        if  newEventView.infoText.text == "" {
            Global.showAlert(title: "Error", message: "Description can not be empty!", viewController: self)
            return
        }
        
        if  self.event.locations.count == 0 {
            Global.showAlert(title: "Error", message: "Locations can not be empty!", viewController: self)
            return
        }
        
        if  self.event.questions.count == 0 {
            Global.showAlert(title: "Error", message: "Questions can not be empty!", viewController: self)
            return
        }
        
        if  self.event.disclaimer == nil || self.event.disclaimer == "" {
            Global.showAlert(title: "Error", message: "Event Disclaimer can not be empty!", viewController: self)
            return
        }
        
        saving = true
        SwiftOverlays.showBlockingWaitOverlay()

        DatabaseHelper.shared.save(event: event) {
            SwiftOverlays.removeAllBlockingOverlays()
            self.saving = false
            _ = self.navigationController?.popToRootViewController(animated: true)
            TSMessage.showNotification(withTitle: "Event has been saved", type: .success)
        }
    }
    
    func toggleSwitch(_ sender: UISwitch) {
        if let type = FieldType(rawValue: sender.tag) {
            event.fields.active(type, active: sender.isOn)
        }
    }
    
    func upload() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            picker.allowsEditing = false
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    func location() {
        let locationVC = NewLocationViewController()
        locationVC.event = event
        navigationController?.pushViewController(locationVC, animated: true)
    }
    
    func question() {
        let questionVC = NewQuestionViewController()
        questionVC.event = event
        navigationController?.pushViewController(questionVC, animated: true)
    }
    
    func disclaimer() {
        let disclaimerVC = NewDisclaimerViewController()
        disclaimerVC.event = event
        navigationController?.pushViewController(disclaimerVC, animated: true)
    }
    
    func priority() {
        event.priority = Int(newEventView.prioritySlider.value)
    }
    
    // tableview
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case newEventView.locationTable:
            return event.locations.count
        case newEventView.questionTable:
            return event.questions.count
        default:
            return FieldType.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        switch tableView {
        case newEventView.locationTable:
            cell.textLabel?.text = event.locations[indexPath.row].location
            return cell
        case newEventView.questionTable:
            cell.textLabel?.text = event.questions[indexPath.row].desc
            return cell
        default:
            let cell = cell as! SwitchTableViewCell
            let field = FieldType(rawValue: indexPath.row)!
            
            if !isNew {
                cell.switchView.isOn = event.fields.isActive(field)
            }
            
            #if Admin
                if field.toString() == "Name" || field.toString() == "Email"{
                    cell.switchView.isOn = false
                    cell.switchView.isEnabled = false
                }
            #endif
           
            
            cell.textLabel?.text = field.toString()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? SwitchTableViewCell {
            cell.switchView.tag = indexPath.row
            cell.switchView.addTarget(self, action: #selector(toggleSwitch), for: .valueChanged)
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? SwitchTableViewCell {
            cell.switchView.tag = -1
            cell.switchView.removeTarget(self, action: #selector(toggleSwitch), for: .valueChanged)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        switch tableView {
        case newEventView.locationTable:
            return true
        case newEventView.questionTable:
            return true
        default:
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete", handler: { action, index in
            switch tableView {
            case self.newEventView.locationTable:
                self.event.locations.remove(at: index.row)
            case self.newEventView.questionTable:
                self.event.questions.remove(at: index.row)
            default:
                break
            }
            
            tableView.reloadData()
            self.newEventView.setNeedsUpdateConstraints()
            self.newEventView.setNeedsLayout()
            self.newEventView.updateConstraintsIfNeeded()
            self.newEventView.layoutIfNeeded()
        })
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit", handler: { action, index in
            switch tableView {
            case self.newEventView.locationTable:
                let locationVC = NewLocationViewController()
                locationVC.event = self.event
                locationVC.location = self.event.locations[index.row]
                self.navigationController?.pushViewController(locationVC, animated: true)
                
            case self.newEventView.questionTable:
                let questionVC = NewQuestionViewController()
                questionVC.event = self.event
                questionVC.question = self.event.questions[index.row]
                self.navigationController?.pushViewController(questionVC, animated: true)

            default:
                break
            }
            
            tableView.reloadData()
        })
        
        return [delete, edit]
    }
    
    
    // empty set
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attrs = [NSForegroundColorAttributeName: Global.colorPrimary.alpha(0.5),
                     NSFontAttributeName: Global.font(20)]
        switch scrollView {
        case newEventView.locationTable:
            return NSAttributedString(string: "No location", attributes: attrs)
        case newEventView.questionTable:
            return NSAttributedString(string: "No question", attributes: attrs)
        default:
            return NSAttributedString(string: "", attributes: attrs)
        }
    }
    
    // text view
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == newEventView.titleText {
            event.title = textView.text
        } else {
            event.info = textView.text
        }
    }
    
    // picker

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        event.localImage = image
        newEventView.imageView.image = event.localImage

        imagePickerControllerDidCancel(picker)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        let barAppearance = UIBarButtonItem.appearance()
        barAppearance.tintColor = UIColor.black
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let barAppearance = UIBarButtonItem.appearance()
        barAppearance.tintColor = UIColor.white
    }
}
