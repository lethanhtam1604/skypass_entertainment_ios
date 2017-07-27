//
//  UITableView.swift
//  Ricochet
//
//  Created by Luu Nguyen on 12/16/16.
//  Copyright © 2016 Lavamy. All rights reserved.
//

import UIKit

extension UITableView {
    func setAndLayoutTableHeaderView(_ header: UIView) {
        self.tableHeaderView = header
        header.setNeedsLayout()
        header.layoutIfNeeded()
        let height = header.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        var frame = header.frame
        frame.size.height = height
        header.frame = frame
        self.tableHeaderView = header
    }
    
    func setAndLayoutTableFooterView(_ footer: UIView) {
        self.tableFooterView = footer
        footer.setNeedsLayout()
        footer.layoutIfNeeded()
        let height = footer.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        var frame = footer.frame
        frame.size.height = height
        footer.frame = frame
        self.tableFooterView = footer
    }

    func scrollToCenter() {
        let center = CGPoint(bounds.midX, bounds.midY)
        if let index = indexPathForRow(at: center) {
            scrollToRow(at: index, at: .middle, animated: true)
        }
    }
}
