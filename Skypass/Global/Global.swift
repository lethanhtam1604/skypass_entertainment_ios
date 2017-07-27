//
//  Global.swift
//  Maxi Unlock
//
//  Created by Luu Nguyen on 10/28/16.
//  Copyright © 2016 Lavamy. All rights reserved.
//

import UIKit

protocol AlertDelegate {
    func okAlertActionClicked()
}

class Global: NSObject {
    // colors
    
    static let colorPrimary = UIColor(0xc12026)
    static let colorPrimaryDark = UIColor(0xc12026)
    static let colorAccent = UIColor(0x484D53)
    static let colorBg = UIColor(0xffffff)
    static let colorBgDark = UIColor(0xf9f9f9)
    static let colorBorder = UIColor(0xc8c7cc)
    static let colorButton = UIColor(0x475A99)
    static let colorLabel = UIColor(0x6e6e70)
    
    // variables

    static let mapKey = "AIzaSyC39FwUfawB4QgAQnfxjMw9YULIxcs0xZA"
    static var filter = FilterType.defaut

    // fonts
    
    static func font(_ size: CGFloat) -> UIFont {
        return UIFont(name: "OpenSans", size: size)!
    }
    
    static func boldFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "OpenSans-Bold", size: size)!
    }
    
    static func lightFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "OpenSans-Light", size: size)!
    }
    
    static func semiboldFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "OpenSans-Semibold", size: size)!
    }
    
    static func showAlert(title: String, message: String, viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    static func showAlertAction(title: String, message: String, viewController: UIViewController, alertDelegate: AlertDelegate?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Notify", style: .default) {
            UIAlertAction in
            if alertDelegate != nil {
                alertDelegate?.okAlertActionClicked()
            }
        }
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
