//
//  QuestionTableViewCell.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/6/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit
import KMPlaceholderTextView

class QuestionTableViewCell: UITableViewCell {
    let questionLabel = UILabel()
    let textView = KMPlaceholderTextView()
    let separator = UIView()
    
    var constraintsAdded = false
    
    var question: Question! {
        didSet {
            questionLabel.text = question.desc
            
            if !(question.answer?.isEmpty ?? true) {
                textView.text = question.answer!
                textView.isEditable = false
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

        contentView.backgroundColor = Global.colorBgDark
        
        separator.backgroundColor = Global.colorBorder
        
        questionLabel.font = Global.font(ip6(38))
        questionLabel.textAlignment = .left
        questionLabel.textColor = Global.colorPrimary
        questionLabel.adjustsFontSizeToFitWidth = true
        questionLabel.numberOfLines = 0
        questionLabel.lineBreakMode = .byWordWrapping

        textView.textContainerInset = UIEdgeInsetsMake(ip6(20), ip6(20), ip6(20), ip6(20))
        textView.font = Global.font(ip6(29.32))
        textView.backgroundColor = Global.colorBg
        textView.placeholder = "Enter your answer"
        textView.tintColor = Global.colorPrimary

        
        contentView.addSubview(questionLabel)
        contentView.addSubview(textView)
        contentView.addSubview(separator)
        
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        if !constraintsAdded {
            constraintsAdded = true
            
            textView.autoPinEdge(toSuperviewEdge: .left)
            textView.autoPinEdge(toSuperviewEdge: .right)
            textView.autoPinEdge(toSuperviewEdge: .bottom)
            textView.autoSetDimension(.height, toSize: ip6(300))
            
            questionLabel.autoPinEdge(toSuperviewEdge: .left, withInset: ip6(20))
            questionLabel.autoPinEdge(toSuperviewEdge: .right, withInset: ip6(20))
            questionLabel.autoPinEdge(toSuperviewEdge: .top, withInset: ip6(20))
            questionLabel.autoPinEdge(.bottom, to: .top, of: textView, withOffset: -ip6(20))
            
            separator.autoPinEdge(toSuperviewEdge: .left)
            separator.autoPinEdge(toSuperviewEdge: .right)
            separator.autoPinEdge(.bottom, to: .top, of: textView)
            separator.autoSetDimension(.height, toSize: px(1))
        }
    }
}
