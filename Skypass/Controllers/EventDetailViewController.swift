//
//  EventDetailViewController.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/5/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    let detailView = EventDetailView()
    
    var event:Event! {
        didSet {
            detailView.infoView.text = event.info
        }
    }
    
    override func loadView() {
        view = detailView
        view.setNeedsUpdateConstraints()
    }
    
    override func viewDidLoad() {
        title = "Event Description"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    
        //enable swipe back when it changed leftBarButtonItem
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
}
