//
//  NewDisclaimerViewController.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/14/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit

class NewDisclaimerViewController: UIViewController {
    let disclaimerView = NewDisclaimerView()
    
    var event:Event! {
        didSet {
            disclaimerView.infoView.text = event.disclaimer
        }
    }
    
    override func loadView() {
        view = disclaimerView
        view.setNeedsUpdateConstraints()
    }
    
    override func viewDidLoad() {
        title = "Disclaimer"
        
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
        event.disclaimer = disclaimerView.infoView.text
        _ = navigationController?.popViewController(animated: true)
    }
}
