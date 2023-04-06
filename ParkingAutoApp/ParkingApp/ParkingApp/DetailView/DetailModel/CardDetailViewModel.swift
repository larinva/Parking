//
//  CardDetailViewModel.swift
//  ParkingApp
//
//  Created by Вячеслав Ларин on 16.03.2023.
//

import Foundation
import SwiftUI
import CoreData


class CardDetailViewModel: ObservableObject {
    
    @Published var calendar = Calendar.current
  
    @Published var datePicker = Date.now
    
    @Published var data = CardDetailModel()
    
    @Published var price = ""
    
    @Published var isPicker: Bool = false
    
}

extension CardDetailViewModel{
    //тот же день следующего месяца
    func nextDayMonth() -> String {
        let dateComponent = calendar.dateComponents([.day], from: .now)
        let nextDate = calendar.nextDate(after: .now, matching: dateComponent, matchingPolicy: .strict)
       
        let formatted = nextDate?.formatted(date: .abbreviated, time: .omitted)
        
        return formatted ?? ""
    }
    
    //оплата за месяц
    func payOfMonth()->String{
        price = ("3 000₽")
        return price
    }
    
    
    //оплата по дням
    func payByDay(dateStart: Date, dateEnd: Date) -> () {
        var dateComponent = calendar.dateComponents([.day], from: dateStart, to: dateEnd)
        dateComponent.timeZone = .current

        let monyDay = dateComponent.day ?? 0
        price = String(monyDay * 100) + "₽"
    }
}

extension CardDetailViewModel{
    
    func loadArendaPlace(idplace: String ,place: FetchedResults<Parking>){
        for item in filterPlaceId(idPlace: idplace, parking: place){
            if item.isArenda{
                data.ovnerAuto = item.ovnerAuto
                data.numberFone = item.numberFone
                data.carBrand = item.carBrand
                data.numberAuto = item.numberAuto
                data.isDatePicker = item.isDatePicker
                data.price = item.price
                data.date = item.date ?? Date()
                data.dateEnd = item.dateEnd ?? Date()
            }
        }
    }
    
    func isHiddenLabel(id: String, parking: FetchedResults<Parking>)->Bool{
        var isId = true
        for item in filterPlaceId(idPlace: id, parking: parking){
            if item.isArenda {
                isId = false
            }
        }
        return isId
    }
}

extension CardDetailViewModel{
    func addItem(idplace: String, context: NSManagedObjectContext){
        let newPlace = Parking(context: context)
            newPlace.ovnerAuto = data.ovnerAuto
            newPlace.numberFone = data.numberFone
            newPlace.carBrand = data.carBrand
            newPlace.numberAuto = data.numberAuto
            newPlace.price = price
            newPlace.isDatePicker = isPicker
            newPlace.date = data.date
            newPlace.dateEnd = data.dateEnd
            
            newPlace.places = Places(context: context)
            newPlace.places.isArenda = true
            newPlace.places.idPlace = idplace
            newPlace.idPlace = idplace
            newPlace.isArenda = true
            
            context.saveContext()
    }
   
    func deleteAllItem(parking: FetchedResults<Parking>, context: NSManagedObjectContext){
        for item in parking{
            context.delete(item)
        }
        context.saveContext()
    }
}
