//
//  AutoView.swift
//  ParkingApp
//
//  Created by vacheslavBook on 06.02.2023.
//

import SwiftUI

struct AutoView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: Parking.fetchRequest0())
    private var parking: FetchedResults<Parking>

    
    var body: some View {
        NavigationStack{
            List{
                ForEach(parking) { item in
                    VStack(alignment: .leading){
                        Text("\(String(describing: item.ovnerAuto))")
                        Text("\(String(describing: item.numberFone))")
                        Text("\(String(describing: item.carBrand))")
                        Text("\(String(describing: item.numberAuto))")
                        Text("\(String(describing: item.isArenda))")
                        Text("\(String(describing: item.date?.formatted(date: .long, time: .omitted)))")
                    }
                }.onDelete(perform: deleteItem(index:))
            }
        }
        .navigationTitle("Auto View")
    }
    
    private func deleteItem(index: IndexSet){
        index.map { parking[$0] }.forEach(viewContext.delete)
        viewContext.saveContext()
    }
}

struct AutoView_Previews: PreviewProvider {
    static var previews: some View {
        AutoView()
    }
}
