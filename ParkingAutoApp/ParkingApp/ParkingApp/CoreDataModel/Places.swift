//
//  Places.swift
//  ParkingApp
//
//  Created by vacheslavBook on 09.02.2023.
//

import CoreData


extension Places{
    var idPlace: String{
        get{ idPlace_ ?? "" }
        set{ idPlace_ = newValue }
    }
    
    var isArenda: Bool{
        get{ isArenda_ }
        set{ isArenda_ = newValue }
    }
    
    var title: String{
        get{ title_ ?? "" }
        set{ title_ = newValue }
    }
    
    var idNumber: Parking{
        get{ parking_! }
        set{ parking_ = newValue }
    }
    
    static func fetchRequest1() -> NSFetchRequest<Places> {
        let request = NSFetchRequest<Places>(entityName: "Places")
        request.sortDescriptors = [NSSortDescriptor(key: "idPlace_", ascending: true)]
        request.predicate = nil
        return request
    }
    
    static func fetchIdPlace(_ idplace: String, context: NSManagedObjectContext)->Places{
        let request = NSFetchRequest<Places>(entityName: "Places")
        request.sortDescriptors = [NSSortDescriptor(key: "idPlace_", ascending: true)]
        let places = (try? context.fetch(request) )
        if let place = places?.last{
            return place
        } else{
            let place = Places(context: context)
            place.idPlace = idplace
            return place
        }
    }
    
    static func update1(from node: NodeId, in context: NSManagedObjectContext){
        if let idplace = node.ids{
            let place = fetchIdPlace(idplace, context: context)
            place.idPlace = node.ids ?? ""
            place.title = node.title
//            place.isArenda = node.isArenda
            place.objectWillChange.send()

            context.saveContext()
        }
    }
    
    static func update(from node: NodeId, in context: NSManagedObjectContext){
        let place = Places(context: context)
        place.idPlace = node.ids ?? ""
//        place.isArenda = node.isArenda
        place.title = node.title
        context.saveContext()
    }
    
    static func delete(in context: NSManagedObjectContext){
        print("delete")
        let request = fetchRequest()
        let result = ( try? context.fetch(request))
        
        if let result = result{
            for element in 0..<result.count{
                context.delete(result[element] )
            }
        }
        context.saveContext()
    }
}
