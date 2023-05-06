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

    @State private var isDetailInfo: Bool = false
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(parking) { place in
                    VStack(alignment: .leading){
                        NavigationLink(value: place){
                            VStack(alignment: .leading){
                                Text("Парковочное место " + (place.idPlace ?? ""))
                                StatusArendaView(isStatus: place.isArenda)
                            }
                        }
                    }
                    
                }.onDelete(perform: deleteItem(index:))
            }//List
            .navigationDestination(for: Parking.self) { place in
                CardParkingPlaceView(idPlace: place.idPlace ?? "", isStatusArenda: place.isArenda)
                let _ = print(place.isArenda)
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
