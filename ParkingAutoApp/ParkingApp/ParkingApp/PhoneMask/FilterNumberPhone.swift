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
        let numbers = auto.replacingOccurrences(of: "^[а-яё\\-\\s]{1}[0-9]{3}(?<!0{3})[а-яё\\-\\s]{2}[0-9]{2}$", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        
        for ch in mask where index < numbers.endIndex{
            //print(numbers)
            if ch == "a"{
                //print(numbers[index])
                result.append(numbers[index])
                index = numbers.index(after: index)
                print(index)
            }
            
            /*if ch == "X"{
                result.append(numbers[index])
                index = numbers.index(after: index)
            }*/
            
            else {
                result.append(ch)
            }
        }
        return result
    }
}
