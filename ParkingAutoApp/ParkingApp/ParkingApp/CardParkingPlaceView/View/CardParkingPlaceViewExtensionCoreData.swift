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
        cardDetailViewModel.isArendaPlaceCoreData(
            idPlace ?? "", isArenda,
            context: viewContext
        )
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
}
