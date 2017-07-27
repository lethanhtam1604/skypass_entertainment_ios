//
//  NewQuestionViewController.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/14/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit

class NewQuestionViewController: UIViewController {
    let disclaimerView = NewDisclaimerView()
    
    var event:Event!
    
    var question:Question? {
        didSet {
            disclaimerView.infoView.text = question?.desc ?? ""
        }
    }
    
    override func loadView() {
        disclaimerView.infoLabel.text = "Please provide question for event?"
        view = disclaimerView
        view.setNeedsUpdateConstraints()
    }
    
    override func viewDidLoad() {
        title = "Question"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(save))
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        //enable swipe back when it changed leftBarButtonItem
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    func save() {
        if disclaimerView.infoView.text.isEmpty {
            alert(message: "Question cannot be empty", title: "Error")
            return
        }
        
        if question == nil {
            let question = Question()
            question.id = UUID().uuidString
            question.desc = disclaimerView.infoView.text
            event.questions.append(question)
        } else {
            question!.desc = disclaimerView.infoView.text
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
}
