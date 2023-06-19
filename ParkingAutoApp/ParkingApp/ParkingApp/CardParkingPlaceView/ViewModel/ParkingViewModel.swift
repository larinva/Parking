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
//    @Published var isPicker: Bool = false
    @Published var datePicker = Date.now
    @Published var price = ""
    
    @Published private (set) var calendar = Calendar.current
    @Published private (set) var maskPhone = "+X-XXX-XXX-XX-XX"
}

extension ParkingViewModel{
    //тот же день следующего месяца
    var nextDayMonth: String {
        let dateComponent = calendar.dateComponents([.day], from: .now)
        let nextDate = calendar.nextDate(after: .now, matching: dateComponent, matchingPolicy: .strict)
        let formatted = nextDate?.formatted(date: .abbreviated, time: .omitted)
        
        return formatted ?? ""
    }
    
    //оплата за месяц
    var payOfMonth: String{
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
                FilterNumberPhone.format(with: self.maskPhone, phone: self.data.numberFone)
            },
            set: {
                self.data.numberFone = $0
            }
        )
        return textChangeBinding
    }
}

extension ParkingViewModel{
    func loadCoreData(idplace: String, context: NSManagedObjectContext) -> () {
        let place = Parking.load(idplace: idplace, cardClient: data, context: context)
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
    
    func setStatusRent(_ idplace: String, _ isArenda: Bool, context: NSManagedObjectContext) -> () {
        Parking.setStatusRent(idplace, isArenda, context: context)
    }
    
    func getStatusRent(idplace: String, context: NSManagedObjectContext)->Bool{
        let place = Parking.withParkingPlace(id: idplace, context: context)
        return place.isArenda
    }
    
    
    func addCoreData(idplace: String, context: NSManagedObjectContext){
        Parking.add(id: idplace, from: data, context: context)
    }
    
    func updateCoreData(idplace: String, isArenda: Bool, context: NSManagedObjectContext) -> () {
        Parking.update(id: idplace, from: data, isArenda: isArenda, in: context)
    }
}
