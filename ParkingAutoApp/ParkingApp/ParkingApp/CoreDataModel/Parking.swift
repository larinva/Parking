//
//  Parking.swift
//  ParkingApp
//
//  Created by vacheslavBook on 06.02.2023.
//

import CoreData

extension Parking: Comparable{
    
    static func fetchRequest0(_ request: NSPredicate) -> NSFetchRequest<Parking> {
        let request = NSFetchRequest<Parking>(entityName: "Parking")
        request.predicate = nil
        request.sortDescriptors = [NSSortDescriptor(key: "ovnerAuto_", ascending: true)]
        return request
    }
    
    static func searchPredicate(query: String, field: String)-> NSPredicate?{
        if query.isEmpty{
            return nil
        } else{
            return NSPredicate(format: "%K BEGINSWITH[cd] %@", field, query)
        }
    }
    
    static func withParkingPlace(id: String, context: NSManagedObjectContext)-> Parking{
        let request = fetchRequest0(NSPredicate(format: "idPlace = %@", id))
        let places = (try? context.fetch(request)) ?? []
//        if let place = places.first {
//            return place
//        } else {
//            let place = Parking(context: context)
//            return place
//        }
        var parking = Parking(context: context)
        for place in places {
            parking = place
        }
        return parking
    }
    
    static func add(id: String, from cardClient: CardParkingPlaceModel, context: NSManagedObjectContext){
        let newPlace = Parking(context: context)
        newPlace.ovnerAuto = cardClient.ovnerAuto
        newPlace.numberFone = cardClient.numberFone
        newPlace.carBrand = cardClient.carBrand
        newPlace.numberAuto = cardClient.numberAuto
        newPlace.price = cardClient.price
        newPlace.isDatePicker = cardClient.isDatePicker
        newPlace.date = cardClient.date
        newPlace.dateEnd = cardClient.dateEnd
        
        newPlace.places = Places(context: context)
        newPlace.places.isArenda = true
        newPlace.places.idPlace = id
        newPlace.idPlace = id
        newPlace.isArenda = true
        
        context.saveContext()
    }
    
    static func load(idplace: String, in context: NSManagedObjectContext){
        let parking = withParkingPlace(id: idplace, context: context)
        
       
        print(parking)
        
//        for item in parking.{
//            if parking.isArenda{
//                cardClient.ovnerAuto = parking.ovnerAuto
//
//        parking.ovnerAuto = cardClient.ovnerAuto
//        parking.numberFone = cardClient.numberFone
//        parking.carBrand = cardClient.carBrand
//        parking.numberAuto = cardClient.numberAuto
//        parking.isDatePicker = cardClient.isDatePicker
//        parking.price = cardClient.price
//        parking.date = cardClient.date
//        parking.dateEnd = cardClient.dateEnd
//
////                context.saveContext()
//            }
//        }
    }
    
    static func update(id: String, from cardClient: CardParkingPlaceModel, in context: NSManagedObjectContext){
        let parking = withParkingPlace(id: id, context: context)
        parking.idPlace = id
        parking.ovnerAuto = cardClient.ovnerAuto
        parking.numberFone = cardClient.numberFone
        parking.carBrand = cardClient.carBrand
        parking.numberAuto = cardClient.numberAuto
        parking.isDatePicker = cardClient.isDatePicker
        parking.price = cardClient.price
        parking.date = cardClient.date
        parking.dateEnd = cardClient.dateEnd

        context.saveContext()
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
