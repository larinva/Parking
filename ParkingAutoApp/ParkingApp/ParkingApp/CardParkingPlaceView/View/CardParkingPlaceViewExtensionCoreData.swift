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
        if isArenda == true {
            print("CardParkingPlaceView \(isArenda)")
            addData()
            /*parkingViewModel.setStatusRent(
                id, isArenda,
                context: viewContext
            )*/
            
        }else {
            print("CardParkingPlaceView true \(isArenda)")
            parkingViewModel.updateCoreData(
                idplace: id,
                isArenda: isArenda,
                context: viewContext
            )
            
            /*parkingViewModel.setStatusRent(
                id, isArenda,
                context: viewContext
            )*/
        }
    }
    
    func addData(){
        parkingViewModel.addCoreData(
            idplace: id,
            context: viewContext
        )
    }
    
    func saveData(){
        parkingViewModel.updateCoreData(
            idplace: id,
            isArenda: isStatusArenda,
            context: viewContext
        )
    }
}
