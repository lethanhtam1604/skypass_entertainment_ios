//
//  NewEventView.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/6/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit
import KMPlaceholderTextView

class NewEventView: UIView {
    let scrollView = UIScrollView()
    let containerView = UIView()
    
    let imageViewDesc = UILabel()
    let imageView = UIImageView()
    let titleText = KMPlaceholderTextView()
    let uploadButton = UIButton()
    
    let infoLabel = UILabel()
    let infoText = KMPlaceholderTextView()
    
    let locationLabel = UILabel()
    let locationButton = UIButton()
    let locationTable = UITableView()
    
    let questionLabel = UILabel()
    let questionButton = UIButton()
    let questionTable = UITableView()
    
    let disclaimerButton = UIButton()
    let disclaimerIndicator = UIImageView(image: UIImage(named: "forward.png"))
    
    let priorityView = UIView()
    let priorityLabel = UILabel()
    let priorityValue = UILabel()
    let prioritySlider = UISlider()
    
    let fieldLabel = UILabel()
    let fieldTable = UITableView()
    
    var separators = [UIView]()

    
    var constraintsAdded = false
    var constraintLocationHeight: NSLayoutConstraint?
    var constraintQuestionHeight: NSLayoutConstraint?
    var constraintFieldHeight: NSLayoutConstraint?
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        backgroundColor = Global.colorBgDark
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = true
        
        imageViewDesc.font = Global.font(ip6(28))
        imageViewDesc.textAlignment = .center
        imageViewDesc.textColor = UIColor.white
        imageViewDesc.adjustsFontSizeToFitWidth = false
        imageViewDesc.numberOfLines = 1
        imageViewDesc.lineBreakMode = .byWordWrapping
        imageViewDesc.text = "No image"
        imageViewDesc.backgroundColor = UIColor.lightGray

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        uploadButton.setTitle("Upload", for: .normal)
        uploadButton.setTitleColor(Global.colorButton, for: .normal)
        uploadButton.setTitleColor(Global.colorButton.alpha(0.2), for: .highlighted)
        uploadButton.layer.cornerRadius = 2
        uploadButton.layer.borderColor = Global.colorButton.cgColor
        uploadButton.layer.borderWidth = 1
        uploadButton.clipsToBounds = true
        uploadButton.backgroundColor = UIColor.clear
        uploadButton.titleLabel?.font = Global.font(ip6(22))
        
        titleText.textContainerInset = UIEdgeInsetsMake(ip6(20), ip6(20), ip6(20), ip6(20))
        titleText.font = Global.font(ip6(28))
        titleText.backgroundColor = Global.colorBg
        titleText.placeholder = "Enter event title"
        titleText.tintColor = Global.colorPrimary

        infoLabel.font = Global.font(ip6(28))
        infoLabel.textAlignment = .right
        infoLabel.textColor = Global.colorLabel
        infoLabel.adjustsFontSizeToFitWidth = false
        infoLabel.numberOfLines = 1
        infoLabel.lineBreakMode = .byWordWrapping
        infoLabel.text = "DESCRIPTION"

        infoText.textContainerInset = UIEdgeInsetsMake(ip6(20), ip6(20), ip6(20), ip6(20))
        infoText.font = Global.font(ip6(28))
        infoText.backgroundColor = Global.colorBg
        infoText.placeholder = "Enter event description"
        infoText.tintColor = Global.colorPrimary
        
        locationLabel.copy(from: infoLabel)
        locationLabel.text = "LOCATIONS"
        
        let plus = UIImage(named: "plus.png")?.withRenderingMode(.alwaysTemplate)
        
        locationButton.setImage(plus, for: .normal)
        locationButton.tintColor = Global.colorPrimary
        
        questionLabel.copy(from: infoLabel)
        questionLabel.text = "QUESTIONS"
        
        questionButton.setImage(plus, for: .normal)
        questionButton.tintColor = Global.colorPrimary

        disclaimerButton.setTitle("Event Disclaimer", for: .normal)
        disclaimerButton.setTitleColor(UIColor.black, for: .normal)
        disclaimerButton.setTitleColor(UIColor.black.alpha(0.2), for: .highlighted)
        disclaimerButton.titleLabel?.font = Global.font(ip6(34))
        disclaimerButton.titleLabel?.textAlignment = .left
        disclaimerButton.backgroundColor = Global.colorBg
        disclaimerButton.contentEdgeInsets = UIEdgeInsetsMake(0, ip6(20), 0, 0)
        disclaimerButton.contentHorizontalAlignment = .left

        disclaimerIndicator.contentMode = .scaleAspectFit

        priorityView.backgroundColor = Global.colorBg
        
        priorityLabel.font = Global.font(ip6(34))
        priorityLabel.textAlignment = .left
        priorityLabel.textColor = UIColor.black
        priorityLabel.text = "Priority"
        priorityLabel.backgroundColor = Global.colorBg

        priorityValue.copy(from: priorityLabel)
        priorityValue.text = "0"
        priorityValue.textAlignment = .right
        
        prioritySlider.backgroundColor = Global.colorBg
        prioritySlider.isContinuous = true
        prioritySlider.minimumValue = 0
        prioritySlider.maximumValue = 10
        prioritySlider.addTarget(self, action: #selector(updatePriority), for: .valueChanged)

        fieldLabel.copy(from: infoLabel)
        fieldLabel.text = "FIELDS"
        
        locationTable.backgroundColor = Global.colorBg
        locationTable.separatorStyle = .singleLine
        locationTable.bounces = false
        locationTable.tableFooterView = UIView()
        locationTable.allowsSelection = false
        locationTable.showsVerticalScrollIndicator = false
        locationTable.showsHorizontalScrollIndicator = false
        locationTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        questionTable.backgroundColor = Global.colorBg
        questionTable.separatorStyle = .singleLine
        questionTable.bounces = false
        questionTable.tableFooterView = UIView()
        questionTable.allowsSelection = false
        questionTable.showsVerticalScrollIndicator = false
        questionTable.showsHorizontalScrollIndicator = false
        questionTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        fieldTable.backgroundColor = Global.colorBg
        fieldTable.separatorStyle = .singleLine
        fieldTable.bounces = false
        fieldTable.tableFooterView = UIView()
        fieldTable.allowsSelection = false
        fieldTable.showsVerticalScrollIndicator = false
        fieldTable.showsHorizontalScrollIndicator = false
        fieldTable.register(SwitchTableViewCell.self, forCellReuseIdentifier: "cell")

        priorityView.addSubview(priorityLabel)
        priorityView.addSubview(priorityValue)
        priorityView.addSubview(prioritySlider)

        containerView.addSubview(imageViewDesc)
        containerView.addSubview(imageView)
        containerView.addSubview(titleText)
        containerView.addSubview(uploadButton)
        containerView.addSubview(infoLabel)
        containerView.addSubview(infoText)
        containerView.addSubview(locationLabel)
        containerView.addSubview(locationButton)
        containerView.addSubview(locationTable)
        containerView.addSubview(questionLabel)
        containerView.addSubview(questionButton)
        containerView.addSubview(questionTable)
        containerView.addSubview(disclaimerButton)
        containerView.addSubview(disclaimerIndicator)
        containerView.addSubview(priorityView)
        containerView.addSubview(fieldLabel)
        containerView.addSubview(fieldTable)
        
        for _ in 0..<5 {
            let separator = UIView()
            separator.backgroundColor = Global.colorBorder
            separators.append(separator)
            containerView.addSubview(separator)
        }
        
        scrollView.addSubview(containerView)
        addSubview(scrollView)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        if !constraintsAdded {
            constraintsAdded = true
            
            scrollView.autoPinEdgesToSuperviewEdges()
            
            imageView.autoPinEdge(toSuperviewMargin: .left)
            imageView.autoPinEdge(toSuperviewEdge: .top, withInset: ip6(25))
            imageView.autoMatch(.width, to: .width, of: self, withMultiplier: 280 / 750)
            imageView.autoMatch(.height, to: .width, of: imageView, withMultiplier: 354 / 275)

            imageViewDesc.autoPinEdge(.left, to: .left, of: imageView)
            imageViewDesc.autoPinEdge(.right, to: .right, of: imageView)
            imageViewDesc.autoPinEdge(.top, to: .top, of: imageView)
            imageViewDesc.autoPinEdge(.bottom, to: .bottom, of: imageView)
            
            uploadButton.autoAlignAxis(.vertical, toSameAxisOf: imageView)
            uploadButton.autoMatch(.width, to: .width, of: imageView)
            uploadButton.autoSetDimension(.height, toSize: ip6(52))
            uploadButton.autoPinEdge(.top, to: .bottom, of: imageView, withOffset: ip6(18))
            
            titleText.autoPinEdge(.top, to: .top, of: imageView)
            titleText.autoPinEdge(.bottom, to: .bottom, of: uploadButton)
            titleText.autoPinEdge(.left, to: .right, of: imageView, withOffset: ip6(26))
            titleText.autoPinEdge(toSuperviewMargin: .right)
            
            infoLabel.autoPinEdge(.top, to: .bottom, of: uploadButton, withOffset: ip6(50))
            infoLabel.autoPinEdge(toSuperviewEdge: .left, withInset: ip6(30))
            
            infoText.autoPinEdge(.top, to: .bottom, of: infoLabel, withOffset: ip6(25))
            infoText.autoPinEdge(toSuperviewEdge: .left)
            infoText.autoPinEdge(toSuperviewEdge: .right)
            infoText.autoSetDimension(.height, toSize: ip6(180))
            
            locationLabel.autoPinEdge(.top, to: .bottom, of: infoText, withOffset: ip6(30))
            locationLabel.autoPinEdge(toSuperviewEdge: .left, withInset: ip6(30))
            
            locationButton.autoAlignAxis(.horizontal, toSameAxisOf: locationLabel)
            locationButton.autoPinEdge(toSuperviewMargin: .right)
            locationButton.autoSetDimensions(to: CGSize(ip6(32),ip6(32)))
            
            locationTable.autoPinEdge(toSuperviewEdge: .left)
            locationTable.autoPinEdge(toSuperviewEdge: .right)
            locationTable.autoPinEdge(.top, to: .bottom, of: locationLabel, withOffset: ip6(25))
            constraintLocationHeight = locationTable.autoSetDimension(.height, toSize: 44)
            
            questionLabel.autoPinEdge(.top, to: .bottom, of: locationTable, withOffset: ip6(30))
            questionLabel.autoPinEdge(toSuperviewEdge: .left, withInset: ip6(30))
            
            questionButton.autoAlignAxis(.horizontal, toSameAxisOf: questionLabel)
            questionButton.autoPinEdge(toSuperviewMargin: .right)
            questionButton.autoSetDimensions(to: CGSize(ip6(32),ip6(32)))
            
            questionTable.autoPinEdge(toSuperviewEdge: .left)
            questionTable.autoPinEdge(toSuperviewEdge: .right)
            questionTable.autoPinEdge(.top, to: .bottom, of: questionLabel, withOffset: ip6(25))
            constraintQuestionHeight = questionTable.autoSetDimension(.height, toSize: 44)
            
            disclaimerButton.autoPinEdge(toSuperviewEdge: .left)
            disclaimerButton.autoPinEdge(toSuperviewEdge: .right)
            disclaimerButton.autoPinEdge(.top, to: .bottom, of: questionTable, withOffset: ip6(80))
            disclaimerButton.autoSetDimension(.height, toSize: ip6(90))
            
            disclaimerIndicator.autoPinEdge(toSuperviewMargin: .right)
            disclaimerIndicator.autoSetDimensions(to: CGSize(ip6(32),ip6(32)))
            disclaimerIndicator.autoAlignAxis(.horizontal, toSameAxisOf: disclaimerButton)
            
            priorityView.autoPinEdge(toSuperviewEdge: .left)
            priorityView.autoPinEdge(toSuperviewEdge: .right)
            priorityView.autoSetDimension(.height, toSize: ip6(166))
            priorityView.autoPinEdge(.top, to: .bottom, of: disclaimerButton, withOffset: ip6(0))
            
            priorityLabel.autoPinEdge(toSuperviewEdge: .left, withInset: ip6(20))
            priorityLabel.autoPinEdge(toSuperviewEdge: .top, withInset: ip6(32))
            
            priorityValue.autoPinEdge(toSuperviewEdge: .right, withInset: ip6(20))
            priorityValue.autoPinEdge(toSuperviewEdge: .top, withInset: ip6(32))

            prioritySlider.autoPinEdge(toSuperviewEdge: .left, withInset: ip6(20))
            prioritySlider.autoPinEdge(toSuperviewEdge: .right, withInset: ip6(20))
            prioritySlider.autoPinEdge(.top, to: .bottom, of: priorityLabel, withOffset: ip6(25))
            
            fieldLabel.autoPinEdge(.top, to: .bottom, of: priorityView, withOffset: ip6(40))
            fieldLabel.autoPinEdge(toSuperviewEdge: .left, withInset: ip6(30))

            fieldTable.autoPinEdge(.top, to: .bottom, of: fieldLabel, withOffset: ip6(22))
            constraintFieldHeight = fieldTable.autoSetDimension(.height, toSize: 44)
            fieldTable.autoPinEdge(toSuperviewEdge: .left)
            fieldTable.autoPinEdge(toSuperviewEdge: .right)
            
            let views = [infoText, locationTable, questionTable, priorityView, fieldTable]
            for i in 0..<separators.count {
                separators[i].autoPinEdge(toSuperviewEdge: .right)
                separators[i].autoSetDimension(.height, toSize: px(1))
                separators[i].autoPinEdge(.bottom, to: .top, of: views[i], withOffset: 0)

                if views[i] == priorityView {
                    separators[i].autoPinEdge(toSuperviewMargin: .left)
                } else {
                    separators[i].autoPinEdge(toSuperviewEdge: .left)
                }
            }
        }
    }
    
    func updatePriority() {
        priorityValue.text = "\(Int(prioritySlider.value))"
    }
}
