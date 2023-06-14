//
//  AutoView.swift
//  ParkingApp
//
//  Created by vacheslavBook on 06.02.2023.
//

import SwiftUI
import CoreData

struct AutoView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: Parking.fetchRequest0(.none))
    private var parking: FetchedResults<Parking>
    
    @State private var isDetailInfo: Bool = false
    @State private var searchText = ""
    
    var delete: some View{
        Button("delete") {
            Parking.delete(in: viewContext)
        }
    }
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(parking) { place in
                    VStack(alignment: .leading){
                        NavigationLink(value: place){
                            VStack(alignment: .leading, spacing: 8){
                                Text(PersonData.ovnerAuto + place.ovnerAuto)
                                Text(PersonData.numberFone + place.numberFone)
                                Text(PersonData.carBrand + place.carBrand)
                                Text(PersonData.numberAuto + place.numberAuto)
                                Text(PersonData.parkingPlace + " " + (place.idPlace ?? ""))
                                StatusArendaView(isStatus: place.isArenda)
                            }
                        }
                    }
                    
                }.onDelete(perform: deleteItem(index:))
            }//List
            .navigationDestination(for: Parking.self) { place in
                CardParkingPlaceView(id: place.idPlace ?? "",
                                     isStatusArenda: place.isArenda,
                                     isCancelButton: false) //false
                
            }
            .navigationTitle(PersonData.listClients)
            .searchable(text: $searchText)
            .onChange(of: searchText) { newValue in
                parking.sortDescriptors = [SortDescriptor(\.numberFone_)]
                parking.nsPredicate = !newValue.isEmpty ? Parking.searchPredicate(query: newValue, field: "numberFone_") : .all
            }
            .navigationBarItems(trailing: delete)
            
        }
    }
    
    //    var search: FetchedResults<Parking>{
    //        if searchText.isEmpty{
    //            return parking
    //        } else{
    //            return parking.filter { $0.numberFone.inc (searchText)}
    //        }
    //    }
    
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
