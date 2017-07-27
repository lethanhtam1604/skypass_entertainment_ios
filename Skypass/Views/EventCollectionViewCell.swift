//
//  EventCollectionViewCell.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/5/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit
import SDWebImage

class EventCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    let nameLabel = UILabel()
    
    var constraintsAdded = false
    
    var event: Event! {
        didSet {
            imageView.sd_setImage(with: URL(unsafeString: event.image))
            nameLabel.text = event.title
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        backgroundColor = UIColor.clear
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.darkGray
        imageView.sd_setShowActivityIndicatorView(true)
        
        nameLabel.font = Global.font(ip6(25.63))
        nameLabel.textColor = UIColor.darkText
        nameLabel.textAlignment = .center
        nameLabel.adjustsFontSizeToFitWidth = false
        nameLabel.numberOfLines = 2
        nameLabel.lineBreakMode = .byTruncatingTail
        
        addSubview(imageView)
        addSubview(nameLabel)
        self.setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        if !constraintsAdded {
            constraintsAdded = true
            
            nameLabel.autoPinEdge(.left, to: .left, of: imageView)
            nameLabel.autoPinEdge(.right, to: .right, of: imageView)
            nameLabel.autoPinEdge(toSuperviewEdge: .bottom)
            nameLabel.autoSetDimension(.height, toSize: ip6(100))
            
            imageView.autoPinEdge(toSuperviewEdge: .left)
            imageView.autoPinEdge(toSuperviewEdge: .right)
            imageView.autoPinEdge(toSuperviewEdge: .top)
            imageView.autoPinEdge(.bottom, to: .top, of: nameLabel)
        }
        
        super.updateConstraints()
    }
}
