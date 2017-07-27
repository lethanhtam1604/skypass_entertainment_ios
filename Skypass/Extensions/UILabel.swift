//
//  UIButton.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/11/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit

extension UILabel {
    func copy(from: UILabel) {
        font = from.font
        textAlignment = from.textAlignment
        backgroundColor = from.backgroundColor
        textColor = from.textColor
        adjustsFontSizeToFitWidth = from.adjustsFontSizeToFitWidth
        numberOfLines = from.numberOfLines
        lineBreakMode = from.lineBreakMode
    }
}
