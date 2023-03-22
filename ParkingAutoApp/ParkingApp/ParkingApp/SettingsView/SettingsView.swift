//
//  SettingView.swift
//  ParkingApp
//
//  Created by vacheslavBook on 06.02.2023.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: Places.fetchRequest1(), animation: .default)
    var places: FetchedResults<Places>

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
            List {
                Section(header: Text( "Список парковочных мест")){
                    ForEach(places) { place in
                        Text(String(describing: place.idPlace))
                        Text(String(describing: place.isArenda))
                    }
                    .onDelete(perform: deleteItem(index: ))
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
