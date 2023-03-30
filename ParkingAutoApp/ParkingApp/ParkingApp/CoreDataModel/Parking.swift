//
//  Parking.swift
//  ParkingApp
//
//  Created by vacheslavBook on 06.02.2023.
//

import CoreData

extension Parking: Comparable{
    
    static func fetchRequest0() -> NSFetchRequest<Parking> {
        let request = NSFetchRequest<Parking>(entityName: "Parking")
        request.predicate = nil
        request.sortDescriptors = [NSSortDescriptor(key: "ovnerAuto_", ascending: true)]
        return request
    }
    
    var ovnerAuto: String{
        get{ ovnerAuto_ ?? "" }
        set{ ovnerAuto_ = newValue }
    }
    
    var numberFone: String{
        get{ numberFone_ ?? "" }
        set{ numberFone_ = newValue }
    }
    
    var carBrand: String{
        get{ carBrand_ ?? "" }
        set{ carBrand_ = newValue }
    }
    
    var numberAuto: String{
        get{ numberAuto_ ?? "" }
        set{ numberAuto_ = newValue }
    }
    
    var places: Places{
        get{ places_ ?? Places() }
        set{ places_ = newValue }
    }
    
    var price: String{
        get{ price_ ?? "" }
        set{ price_ = newValue }
    }
    
    public static func < (lhs: Parking, rhs: Parking) -> Bool {
        lhs.ovnerAuto < rhs.ovnerAuto
    }
}
