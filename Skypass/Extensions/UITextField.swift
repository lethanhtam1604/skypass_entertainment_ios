//
//  UITextView.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/6/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit

extension UITextField {
    func makeDatePickerWithDoneButton() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
        self.inputView = datePicker
    }
    
    func handleDatePicker(_ sender: UIDatePicker) {
        text = sender.date.dateString
    }

    func makeTimePickerWithDoneButton() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.addTarget(self, action: #selector(handleTimePicker), for: .valueChanged)
        self.inputView = datePicker
    }
    
    func handleTimePicker(_ sender: UIDatePicker) {
        text = sender.date.timeString
    }
}
