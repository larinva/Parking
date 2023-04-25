//
//  FormatterNumberPhone.swift
//  ParkingApp
//
//  Created by Вячеслав Ларин on 14.04.2023.
//

import UIKit

class ViewController: UIViewController {
    private let maxNumberCount = 11
    private let regix = try! NSRegularExpression(pattern: "[\\+\\s-\\(\\)]", options: .caseInsensitive)
    
    func format(phoneNumber: String, shouldRemoveLastDigit: Bool)->String{
        guard shouldRemoveLastDigit && phoneNumber.count <= 2 else { return "+" }
        let range = NSString(string: phoneNumber).range(of: phoneNumber)
        var number = regix.stringByReplacingMatches(in: phoneNumber, range: range, withTemplate: "")
        
        if number.count > maxNumberCount{
            let maxIndex = number.index(number.startIndex, offsetBy: maxNumberCount)
            number = String(number[number.startIndex..<maxIndex])
        }
        
        if shouldRemoveLastDigit{
            let maxIndex = number.index(number.startIndex, offsetBy: number.count - 1)
            number = String(number[number.startIndex..<maxIndex])
        }
        
        let maxIndex = number.index(number.startIndex, offsetBy: number.count)
        let regRange = number.startIndex..<maxIndex
        
        if number.count < 7{
            let pattern = "(\\d)(\\d{3}(\\d+))"
            number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3", options: .regularExpression, range: regRange)
            
        } else {
            let pattern = "(\\d)(\\d{3})(\\d{3})(\\d{2})(\\d+))"
            number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3-$4-$5", options: .regularExpression, range: regRange)
            
        }
            return "+" + number
    }
}

extension ViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let fillString = (textField.text ?? "") + string
        textField.text = format(phoneNumber: fillString, shouldRemoveLastDigit: range.length == 1)
        return true
    }
}

