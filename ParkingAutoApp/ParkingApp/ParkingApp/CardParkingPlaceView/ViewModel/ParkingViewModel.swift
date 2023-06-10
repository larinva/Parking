//
//  CardDetailViewModel.swift
//  ParkingApp
//
//  Created by Вячеслав Ларин on 16.03.2023.
//

import Foundation
import SwiftUI
import CoreData


class ParkingViewModel: ObservableObject {
    @Published var data = ParkingPlaceModel()
    @Published var isPicker: Bool = false
    @Published var datePicker = Date.now
    @Published var price = ""
    
    @Published private (set) var calendar = Calendar.current
    @Published private (set) var maskPhone = "+X-XXX-XXX-XX-XX"
    @Published private var textPhone = ""
}

extension ParkingViewModel{
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

extension ParkingViewModel{
    func maskPhoneBinding() -> Binding<String> {
        let textChangeBinding = Binding<String>(
            get: {
                FilterNumberPhone.format(with: self.maskPhone, phone: self.textPhone)
            },
            set: {
                self.textPhone = $0
                self.data.numberFone = $0
            }
        )
        return textChangeBinding
    }
    
    func loadNumberFone() -> () {
        textPhone = data.numberFone
    }
}

extension ParkingViewModel{
    func loadCoreData(id: String, context: NSManagedObjectContext) -> () {
        let place = Parking.load(idplace: id, cardClient: data, context: context)
            data.idPlace = place.idPlace
            data.ovnerAuto = place.ovnerAuto
            data.numberFone = place.numberFone
            data.carBrand = place.carBrand
            data.numberAuto = place.numberAuto
            data.isDatePicker = place.isDatePicker
            data.price = place.price
            data.date = place.date
            data.dateEnd = place.dateEnd
    }
    
    func setStatusRent(_ id: String, _ isArenda: Bool, context: NSManagedObjectContext) -> () {
        let arendaPlace = Parking.withParkingPlace(id: id , context: context)
        arendaPlace.isArenda = isArenda
        arendaPlace.places_?.isArenda = isArenda
        context.saveContext()
    }
    
    func getStatusRent(id: String, context: NSManagedObjectContext)->Bool{
        let place = Parking.withParkingPlace(id: id, context: context)
        return place.isArenda
    }
    
    
    func addCoreData(idplace: String, context: NSManagedObjectContext){
        Parking.add(id: idplace, from: data, context: context)
        print(data)
    }
    
    func saveCoreData(id: String, context: NSManagedObjectContext) -> () {
        Parking.update(id: id, from: data, in: context)
    }
}