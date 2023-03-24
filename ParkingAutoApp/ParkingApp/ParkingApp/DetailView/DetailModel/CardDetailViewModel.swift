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
    @Environment (\.calendar) private var calendar
    @Published var data = CardDetailModel()
}

extension CardDetailViewModel{
    func generateDate(dateStart: Date, dateEnd: Date) -> () {
        var diffs = calendar.dateComponents([.day], from: dateStart, to: dateEnd)
        diffs.timeZone = .current

        let _ = print((diffs.day ?? 0))
        
        let monyDay = ((diffs.day ?? 0))
        //price = String((monyDay) * 100)
    }
    
    func loadArendaPlace(idplace: String ,place: FetchedResults<Parking>){
        for item in filterPlaceId(idPlace: idplace, parking: place){
            if item.isArenda{
                data.ovnerAuto = item.ovnerAuto
                data.numberFone = item.numberFone
                data.carBrand = item.carBrand
                data.numberAuto = item.numberAuto
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
    func addItem(idplace: String, detailViewModel: CardDetailViewModel, context: NSManagedObjectContext){
        let parkingItem = Parking(context: context)
        parkingItem.ovnerAuto = detailViewModel.data.ovnerAuto //ovnerAuto
        parkingItem.numberFone = detailViewModel.data.numberFone
        parkingItem.carBrand = detailViewModel.data.carBrand
        parkingItem.numberAuto = detailViewModel.data.numberAuto
        parkingItem.date = detailViewModel.data.date
        parkingItem.dateEnd = detailViewModel.data.dateEnd
        
        parkingItem.places = Places(context: context)
        parkingItem.places.isArenda = true
        parkingItem.places.idPlace = idplace
        parkingItem.idPlace = idplace
        parkingItem.isArenda = true
        
        context.saveContext()
    }
    
    
    func deleteAllItem(parking: FetchedResults<Parking>, context: NSManagedObjectContext){
        for item in parking{
            context.delete(item)
        }
        context.saveContext()
    }
}
