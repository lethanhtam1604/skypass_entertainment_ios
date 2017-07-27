//
//  UIViewController.swift
//  MusicPlayer
//
//  Created by Unknown on 2/19/17.
//  Copyright © 2017. All rights reserved.
//

import UIKit

extension UIViewController {
    convenience init(title: String) {
        self.init()
        self.title = title
    }
    
    func addChild(_ viewController: UIViewController, container: UIView? = nil) {
        addChildViewController(viewController)
        if let container = container {
            container.addSubview(viewController.view)
            viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        } else {
            view.addSubview(viewController.view)
        }
        viewController.didMove(toParentViewController: self)
    }
    
    func removeChild(_ viewController: UIViewController) {
        viewController.willMove(toParentViewController: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
