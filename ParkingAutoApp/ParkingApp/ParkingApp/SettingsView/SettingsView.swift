//
//  SettingView.swift
//  ParkingApp
//
//  Created by vacheslavBook on 06.02.2023.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: Parking.fetchRequest0(.isArenda), animation: .default)
    var places: FetchedResults<Parking>

    let loadCoreData = LoadPlaces()
    var load: some View {
        Button("Load") {
            LoadPlaces().load()
        }
    }
    var delete: some View{
        Button("delete") {
            Places.delete(in: viewContext)
        }
    }
    
    var body: some View {
        NavigationStack{
            List(places) { place in
                VStack(alignment: .leading){
                    Text(String(describing: place.idPlace))
                    Text(String(describing: place.isArenda))
                    Text(String(describing: place.price))
                    StatusArendaView(isStatus: place.isArenda)
                }
                
            }
            .navigationTitle("Загрузка")
            .navigationBarItems(trailing: delete)
            .navigationBarItems(trailing: load)
        }
    }
    
    private func deleteItem(index: IndexSet){
        index.map { places[$0] }.forEach(viewContext.delete)
        viewContext.saveContext()
    }
}
