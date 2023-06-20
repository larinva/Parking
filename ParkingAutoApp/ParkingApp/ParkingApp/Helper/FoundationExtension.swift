//
//  DateFormatter.swift
//  ParkingApp
//
//  Created by vacheslavBook on 20.06.2023.
//

import Foundation

extension Date{
    var datestring: String{
        let calendar = Calendar.current
        let dateComponent = calendar.dateComponents([.day], from: .now)
        let nextDate = calendar.nextDate(after: .now, matching: dateComponent, matchingPolicy: .strict)
        let formatted = nextDate?.datemenu
        
        guard let date = formatted else { return ""}
        return date
    }
    
    var datemenu: String{
        self.formatted(date: .abbreviated, time: .omitted)
    }
}
