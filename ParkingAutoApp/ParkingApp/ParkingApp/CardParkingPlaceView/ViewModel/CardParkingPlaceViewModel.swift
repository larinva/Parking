//
//  CardDetailViewModel.swift
//  ParkingApp
//
//  Created by Вячеслав Ларин on 16.03.2023.
//

import Foundation
import SwiftUI
import CoreData


class CardParkingPlaceViewModel: ObservableObject {
    @Published var data = CardParkingPlaceModel()
    @Published var isPicker: Bool = false
    @Published var datePicker = Date.now
    @Published var price = ""
    
    @Published private (set) var calendar = Calendar.current
    @Published private (set) var maskPhone = "+X-XXX-XXX-XX-XX"
    @Published private (set) var textPhone = ""
    //@Published private (set) var maskAuto = "xxxxxxxxx"
    //@Published private (set) var textAuto = ""
}

extension CardParkingPlaceViewModel{
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

extension CardParkingPlaceViewModel{
    func maskPhoneBinding() -> Binding<String> {
        let textChangeBinding = Binding<String>(
            get: {
                FilterNumberPhone.format(with: self.maskPhone, phone: self.textPhone)
            },
            set: {
                self.textPhone = $0
            }
        )
        return textChangeBinding
    }
    
    /*func maskAutoBinding() -> Binding<String> {
        let textChangeBinding = Binding<String>(
            get: {
                FilterNumberPhone.formatNumberAuto(with: self.maskAuto, auto: self.textAuto)            },
            set: {
                self.textAuto = $0
            }
        )
        //TextFieldContainer(placeholder: "+7", text: textChangeBinding)
        return textChangeBinding
    }*/
}

extension CardParkingPlaceViewModel{
    
    func loadNumberFone() -> () {
        textPhone = data.numberFone
    }
    
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

extension CardParkingPlaceViewModel{
    func addItem(idplace: String, context: NSManagedObjectContext){
        let newPlace = Parking(context: context)
            newPlace.ovnerAuto = data.ovnerAuto
            newPlace.numberFone = textPhone //data.numberFone
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
