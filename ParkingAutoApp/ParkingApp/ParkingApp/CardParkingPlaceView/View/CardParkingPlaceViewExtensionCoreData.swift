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
        parkingViewModel.isArendaPlaceCoreData(
            idPlace, isArenda,
            context: viewContext
        )
    }
    
    func addData(){
        parkingViewModel.addCoreData(
            idplace: idPlace,
            context: viewContext
        )
    }
    
    func saveData(){
        parkingViewModel.saveCoreData(
            id: idPlace,
            context: viewContext
        )
    }
}
