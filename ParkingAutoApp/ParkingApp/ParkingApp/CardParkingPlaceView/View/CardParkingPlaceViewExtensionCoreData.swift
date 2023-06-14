//
//  CardParkingPlaceViewExtensionCoreData.swift
//  ParkingApp
//
//  Created by vacheslavBook on 01.06.2023.
//

import Foundation

// MARK: Core Data

extension CardParkingPlaceView{
    
    func setStatusRent(isArenda: Bool){
        parkingViewModel.setStatusRent(
            id, isArenda,
            context: viewContext
        )
    }
    
    func addData(){
        parkingViewModel.addCoreData(
            idplace: id,
            context: viewContext
        )
    }
    
    func saveData(){
        parkingViewModel.saveCoreData(
            idplace: id,
            context: viewContext
        )
    }
}
