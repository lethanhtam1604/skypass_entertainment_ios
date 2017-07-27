//
//  String.swift
//  VISUALOGYX
//
//  Created by Luu Nguyen on 10/11/16.
//  Copyright © 2016 Lavamy. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isValidPhone() -> Bool {
        let PHONE_REGEX = "^\\d{8,20}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: self)
        return result
    }
    
    var dateFromISO8601: Date? {
        return Date.Formatter.iso8601.date(from: self)
    }
    
    var dateFromDateString: Date? {
        return Date.Formatter.dateFormat.date(from: self)
    }
    
    var dateFromTimeString: Date? {
        return Date.Formatter.timeFormat.date(from: self)
    }
    
    var date: Date? {
        get {
            if let d = dateFromISO8601 {
                return d
            }
            
            if let d = dateFromDateString {
                return d
            }
            
            if let d = dateFromTimeString {
                return d
            }
            
            return nil
        }
    }
    
    init(htmlEncodedString: String) {
        self.init()
        guard let encodedData = htmlEncodedString.data(using: .utf8) else {
            self = htmlEncodedString
            return
        }
        
        let attributedOptions: [String : Any] = [
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue
        ]
        
        do {
            let attributedString = try NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
            self = attributedString.string
        } catch {
            print("Error: \(error)")
            self = htmlEncodedString
        }
    }
    
    func getQueryStringParameter(_ param: String) -> String? {
        
        if let url = NSURLComponents(string: self) {
            if let items = url.queryItems {
                let needed = items.filter() {
                    (item) in
                    item.name == param
                }
                return needed.first?.value
            }
        }
        
        return nil
    }
}
