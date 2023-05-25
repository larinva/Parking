//
//  CoreDataExtensions.swift
//  ParkingApp
//
//  Created by Вячеслав Ларин on 09.02.2023.
//

import CoreData
import Foundation

extension NSManagedObjectContext{
    
    func saveContext() -> () {
        if self.hasChanges {
            do{
                try self.save()
            } catch {
                let nsError = error as Error
                fatalError("Error \(nsError), \(nsError.localizedDescription)")
            }
        }
    }
}

extension NSPredicate {
    static var all = NSPredicate(format: "TRUEPREDICATE")
    static var none = NSPredicate(format: "FALSEPREDICATE")
}
