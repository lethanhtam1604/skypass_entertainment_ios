//
//  UISearchBar.swift
//  MusicPlayer
//
//  Created by Luu Nguyen on 2/16/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit

extension UISearchBar {
    var textField: UITextField {
        return self.value(forKey: "searchField") as! UITextField
    }
    
    var textColor:UIColor? {
        get {
            return textField.textColor
        }
        
        set (newValue) {
            textField.textColor = newValue
        }
    }
}
