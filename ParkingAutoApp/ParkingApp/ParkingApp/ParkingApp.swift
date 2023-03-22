//
//  ParkingAppApp.swift
//  ParkingApp
//
//  Created by vacheslavBook on 06.02.2023.
//

import SwiftUI

@main
struct ParkingApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
