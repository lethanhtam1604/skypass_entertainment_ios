
//
//  Array.swift
//  Ricochet
//
//  Created by Luu Nguyen on 12/24/16.
//  Copyright © 2016 Lavamy. All rights reserved.
//

extension Array where Element: Equatable {
    mutating func remove(_ object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}
