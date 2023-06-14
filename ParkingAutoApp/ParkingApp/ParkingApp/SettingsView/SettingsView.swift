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
            List(places) { place in
                Section(header: Text("Список парковочных мест")){
                    if place.isArenda{
                        //                    Section(header: Text("Список парковочных мест")){
                        Text(String(describing: place.idPlace))
                        Text(String(describing: place.parking_?.date_))
                        StatusArendaView(isStatus: place.isArenda)
                        //                    }
                    }
                    //                }
//                    else{
//                        Section(header: Text("Список мест не в аренде")) {
//                        Text(String(describing: place.idPlace))
//                        Text(String(describing: place.parking_?.date_ ?? Date.now ))
//                        StatusArendaView(isStatus: place.isArenda)
//                        }
//                    }
                }
            }
            .navigationTitle("Загрузка")
            .navigationBarItems(trailing: delete)
            .navigationBarItems(trailing: load)
//                    .onDelete(perform: deleteItem(index: ))
            .listStyle(.insetGrouped)
        }
    }
    
    private func deleteItem(index: IndexSet){
        index.map { places[$0] }.forEach(viewContext.delete)
        viewContext.saveContext()
    }
}
