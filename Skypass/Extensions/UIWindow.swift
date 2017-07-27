//
//  SetRootViewController.swift
//  VISUALOGYX
//
//  Created by Luu Nguyen on 10/9/16.
//  Copyright © 2016 Lavamy. All rights reserved.
//

import UIKit

extension UIWindow {
    func replaceRootViewControllerWith(_ replacementController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        let snapshotImageView = UIImageView(image: self.snapshot())
        self.addSubview(snapshotImageView)
        self.rootViewController = replacementController
        self.bringSubview(toFront: snapshotImageView)
        if animated {
            UIView.animate(withDuration: 0.4, animations: { () -> Void in
                snapshotImageView.alpha = 0
                }, completion: { (success) -> Void in
                    snapshotImageView.removeFromSuperview()
                    completion?()
            })
        }
        else {
            snapshotImageView.removeFromSuperview()
            completion?()
        }
    }
}
