//
//  DisclaimerViewController.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/5/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit

class DisclaimerViewController: UIViewController {
    let disclaimerView = DisclaimerView()
    
    var event: Event! {
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
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
  
        //enable swipe back when it changed leftBarButtonItem
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
}
