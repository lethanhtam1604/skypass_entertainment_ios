//
//  FieldTableViewCell.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/5/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit
import DownPicker

class FieldTableViewCell: UITableViewCell, LocationDelegate, UITextFieldDelegate {
    let textField = UITextField()
    let iconImage = UIImageView()
    let indicator = UIImageView(image: UIImage(named: "forward.png"))
    let separator = UIView()
    let button = UIButton()
    
    let textView = UILabel()
    let iconView = UIImageView()
    
    var downPicker:DownPicker?
    
    var constraintsAdded = false

    var user: User? {
        didSet {
            let hidden = user != nil
            
            iconView.isHidden = !hidden
            textView.isHidden = !hidden
            textView.lineBreakMode = .byWordWrapping
            textView.numberOfLines = 0
            
            textField.isHidden = hidden
            button.isHidden = hidden
        }
    }
    
    var fieldType: FieldType! {
        didSet {
            downPicker = nil
            
            let attrs = [NSFontAttributeName: Global.lightFont(ip6(34)), NSForegroundColorAttributeName: UIColor(0x7e7e7e)]
        
            switch fieldType! {
            case .name:
                button.isUserInteractionEnabled = false
                textField.isUserInteractionEnabled = true
                textField.rightViewMode = .never
                textField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: attrs)
                textField.keyboardType = .alphabet
                textField.autocorrectionType = .default
                textField.autocapitalizationType = .words
                textField.inputView = nil
                iconImage.image = UIImage(named: "user.png")
                iconView.image = UIImage(named: "user.png")
                textView.text = user?.name ?? "Unknown"
                

            case .email:
                button.isUserInteractionEnabled = false
                textField.isUserInteractionEnabled = true
                textField.rightViewMode = .never
                textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: attrs)
                textField.keyboardType = .emailAddress
                textField.autocorrectionType = .no
                textField.autocapitalizationType = .none
                textField.inputView = nil
                iconImage.image = UIImage(named: "email.png")
                iconView.image = UIImage(named: "email.png")
                textView.text = user?.email ?? "Unknown"
                
            case .gender:
                button.isUserInteractionEnabled = false
                textField.isUserInteractionEnabled = true
                textField.rightViewMode = .always
                textField.tintColor = UIColor(0x7e7e7e)
                iconImage.image = UIImage(named: "sex.png")
                downPicker = DownPicker(textField: textField, withData: ["Male", "Female", "Other"])
                downPicker?.setAttributedPlaceholder(NSAttributedString(string: "Gender", attributes: attrs))
                downPicker?.tintColor = UIColor(0x7e7e7e)
                iconView.image = UIImage(named: "sex.png")
                textView.text = user?.gender ?? "Unknown"
                
            case .birthday:
                button.isUserInteractionEnabled = false
                textField.isUserInteractionEnabled = true
                textField.rightViewMode = .always
                textField.attributedPlaceholder = NSAttributedString(string: "Birthday", attributes: attrs)
                textField.inputView = nil
                textField.makeDatePickerWithDoneButton()
                iconImage.image = UIImage(named: "date.png")
                iconView.image = UIImage(named: "date.png")
                textView.text = user?.birthday?.dateString ?? "Unknown"

            case .phone:
                button.isUserInteractionEnabled = false
                textField.isUserInteractionEnabled = true
                textField.rightViewMode = .never
                textField.attributedPlaceholder = NSAttributedString(string: "Phone", attributes: attrs)
                textField.keyboardType = .phonePad
                textField.autocorrectionType = .no
                textField.autocapitalizationType = .none
                textField.inputView = nil
                iconImage.image = UIImage(named: "phone.png")
                iconView.image = UIImage(named: "phone.png")
                textView.text = user?.phone ?? "Unknown"

            case .location:
                button.isUserInteractionEnabled = true
                textField.isUserInteractionEnabled = false
                textField.rightViewMode = .always
                textField.attributedPlaceholder = NSAttributedString(string: "Location", attributes: attrs)
                textField.inputView = nil
                iconImage.image = UIImage(named: "location.png")
                iconView.image = UIImage(named: "location.png")
                textView.text = user?.location ?? "Unknown"
                
            case .zipcode:
                button.isUserInteractionEnabled = false
                textField.isUserInteractionEnabled = true
                textField.rightViewMode = .never
                textField.attributedPlaceholder = NSAttributedString(string: "Zip Code", attributes: attrs)
                textField.keyboardType = .numberPad
                textField.autocorrectionType = .no
                textField.autocapitalizationType = .none
                textField.inputView = nil
                iconImage.image = UIImage(named: "zipcode.png")
                iconView.image = UIImage(named: "zipcode.png")
                textView.text = user?.zipcode ?? "Unknown"
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        selectionStyle = .none
        
        textField.delegate = self
        textField.font = Global.lightFont(ip6(34))
        textField.tintColor = Global.colorPrimary
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(0,0,ip6(70),ip6(100)))
        textField.rightView = UIView(frame: CGRect(0,0,ip6(60),ip6(100)))
        textField.leftView?.addSubview(iconImage)
        textField.rightView?.addSubview(indicator)

        iconImage.frame = CGRect(ip6(15),ip6(100-25)/2,ip6(25),ip6(25))
        iconImage.contentMode = .scaleAspectFit
        
        indicator.contentMode = .scaleAspectFit
        indicator.frame = iconImage.frame
        
        separator.backgroundColor = Global.colorBorder

        textField.addSubview(separator)
        
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(pickLocation), for: .touchUpInside)

        
        textField.font = Global.lightFont(ip6(34))
        textField.tintColor = Global.colorPrimary
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(0,0,ip6(70),ip6(100)))
        textField.rightView = UIView(frame: CGRect(0,0,ip6(60),ip6(100)))
        textField.leftView?.addSubview(iconImage)
        textField.rightView?.addSubview(indicator)

        iconView.contentMode = .scaleAspectFit
        
        textView.font = Global.lightFont(ip6(36))
        textView.tintColor = Global.colorPrimary
        textView.textColor = UIColor.darkText
        textView.lineBreakMode = .byTruncatingTail
        
        contentView.addSubview(textField)
        contentView.addSubview(button)
        contentView.addSubview(iconView)
        contentView.addSubview(textView)
        
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        if !constraintsAdded {
            constraintsAdded = true

            textField.autoPinEdge(toSuperviewEdge: .left)
            textField.autoPinEdge(toSuperviewEdge: .right)
            textField.autoPinEdge(toSuperviewEdge: .bottom)
            textField.autoSetDimension(.height, toSize: ip6(100))
            
            button.autoPinEdge(toSuperviewEdge: .left)
            button.autoPinEdge(toSuperviewEdge: .right)
            button.autoPinEdge(toSuperviewEdge: .bottom)
            button.autoSetDimension(.height, toSize: ip6(100))

            separator.autoPinEdge(toSuperviewEdge: .left)
            separator.autoPinEdge(toSuperviewEdge: .right)
            separator.autoPinEdge(toSuperviewEdge: .bottom)
            separator.autoSetDimension(.height, toSize: px(1))
            
            iconView.autoPinEdge(toSuperviewEdge: .left, withInset: ip6(40))
            iconView.autoSetDimensions(to: CGSize(ip6(25),ip6(25)))
            iconView.autoAlignAxis(toSuperviewAxis: .horizontal)
            
            textView.autoAlignAxis(toSuperviewAxis: .horizontal)
            textView.autoPinEdge(toSuperviewEdge: .left, withInset: ip6(95))
            textView.autoPinEdge(toSuperviewMargin: .right)
        }
    }
    
    
    // delegate
    
    func pickLocation() {
        let locationVC = LocationViewController()
        locationVC.delegate = self
        viewController()?.navigationController?.pushViewController(locationVC, animated: true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func locationDidChange(_ location: Location?) {
        textField.text = location?.fullAddress
    }
}
