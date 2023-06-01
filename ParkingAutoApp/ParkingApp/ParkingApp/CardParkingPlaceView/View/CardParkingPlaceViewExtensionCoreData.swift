//
//  CardParkingPlaceViewExtensionCoreData.swift
//  ParkingApp
//
//  Created by vacheslavBook on 01.06.2023.
//

import Foundation

// MARK: Core Data

extension CardParkingPlaceView{
    
    func filterPlace(isArenda: Bool){
        for item in filterPlaceId(idPlace: idPlace ?? "", parking: parking){
            item.isArenda = isArenda
            item.places_?.isArenda = isArenda
            viewContext.saveContext()
        }
    }
    
    func addData(){
        cardDetailViewModel.addCoreData(
            idplace: idPlace ?? "",
            context: viewContext
        )
        
    }
    
    func saveData(){
        cardDetailViewModel.saveCoreData(
            id: idPlace ?? "",
            context: viewContext
        )
    }
    
    func deleteItem(){
        cardDetailViewModel.deleteAllItem(
            parking: parking,
            context: viewContext
        )
        
    }
}
