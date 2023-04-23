//
//  FilterNumberPhone.swift
//  ParkingApp
//
//  Created by vacheslavBook on 23.04.2023.
//

import SwiftUI

class FilterNumberPhone: ObservableObject {
    func format(with mask: String, phone: String)-> String{
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        
        for ch in mask where index < numbers.endIndex{
            if ch == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else{
                result.append(ch)
            }
        }
        return result
        
    }
}
