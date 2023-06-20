//
//  NoficationView.swift
//  ParkingApp
//
//  Created by vacheslavBook on 20.06.2023.
//

import SwiftUI

struct NoficationModel {
    
}

class NoficationModelView: ObservableObject {
    @Published var currentDate = Date.now
}

struct NoficationView: View {
    @FetchRequest(fetchRequest: Parking.fetchRequest0(.isArenda)) private var parking: FetchedResults<Parking>
    @ObservedObject var viewModel = NoficationModelView()
    
    var body: some View {
        VStack{
            Text("Текущая дата \(viewModel.currentDate.datemenu)")
            List(parking){ place in
                Text("Место \(place.idPlace ?? "")")
                Text("Дата \(place.deteEnd.datemenu)")
            }
        }
    }
}

struct NoficationView_Previews: PreviewProvider {
    static var previews: some View {
        NoficationView()
    }
}
