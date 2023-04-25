//
//  FilterNumberPhone.swift
//  ParkingApp
//
//  Created by vacheslavBook on 23.04.2023.
//

import SwiftUI

class FilterNumberPhone: ObservableObject {
    static func format(with mask: String, phone: String)-> String{
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
    
    static func formatNumberAuto(with mask: String, auto: String)-> String{
        let numbers = auto.replacingOccurrences(of: "[А-я]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        
        print(numbers)
        
        for ch in mask where index < numbers.endIndex{
//            print(ch)
//            if ch == "a" || ch == "X"{
                //print(numbers[index])
                result.append(numbers[index])
                index = numbers.index(after: index)
//                print("a - \(ch)")
//                print(result.map{$0})
//            }
//            else {
//                result.append(ch)
//            }
        }
        return result
    }
}
