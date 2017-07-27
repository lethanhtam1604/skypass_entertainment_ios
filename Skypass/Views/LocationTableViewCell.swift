//
//  LocationTableViewCell.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/14/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell, LocationDelegate, UITextFieldDelegate {
    let textField = UITextField()
    let iconImage = UIImageView()
    let indicator = UIImageView(image: UIImage(named: "forward.png"))
    let separator = UIView()
    let button = UIButton()
    
    var constraintsAdded = false
    
    var location: Location?
    
    var newLocation: Location?

    var order: Int! {
        didSet {
            let attrs = [NSFontAttributeName: Global.lightFont(ip6(34)), NSForegroundColorAttributeName: UIColor(0x7e7e7e)]
            
            switch order {
            case 0:
                button.isUserInteractionEnabled = false
                textField.isUserInteractionEnabled = true
                textField.rightViewMode = .always
                textField.attributedPlaceholder = NSAttributedString(string: "Venue", attributes: attrs)
                textField.inputView = nil
                textField.text = location?.location ?? ""
                button.isHidden = true
                
            case 1:
                button.isUserInteractionEnabled = true
                textField.isUserInteractionEnabled = false
                textField.rightViewMode = .always
                textField.attributedPlaceholder = NSAttributedString(string: "Location", attributes: attrs)
                textField.inputView = nil
                iconImage.image = UIImage(named: "location.png")
                textField.text = location?.location ?? ""
                textField.rightView?.addSubview(indicator)
                button.isHidden = false

            case 2:
                button.isUserInteractionEnabled = false
                textField.isUserInteractionEnabled = true
                textField.rightViewMode = .always
                textField.attributedPlaceholder = NSAttributedString(string: "Date", attributes: attrs)
                textField.inputView = nil
                textField.makeDatePickerWithDoneButton()
                iconImage.image = UIImage(named: "date.png")
                textField.text = location?.date?.dateString ?? ""
                textField.rightView?.addSubview(indicator)
                button.isHidden = false

            case 3:
                button.isUserInteractionEnabled = false
                textField.isUserInteractionEnabled = true
                textField.rightViewMode = .always
                textField.attributedPlaceholder = NSAttributedString(string: "Time", attributes: attrs)
                textField.inputView = nil
                textField.makeTimePickerWithDoneButton()
                iconImage.image = UIImage(named: "time.png")
                textField.text = location?.time?.timeString ?? ""
                textField.rightView?.addSubview(indicator)
                button.isHidden = false

            default:
                break
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
        
        contentView.addSubview(textField)
        contentView.addSubview(button)
        
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
        newLocation = location
    }
}
