//
//  URL.swift
//  MusicPlayer
//
//  Created by Luu Nguyen on 2/20/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import Foundation

extension URL {
    init?(unsafeString: String?) {
        var url = unsafeString == nil ? "" : unsafeString!
        if !url.hasPrefix("http") {
            url = "http://\(url)"
        }
        let encoded = (url as NSString).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        self.init(string: encoded)
    }
}
