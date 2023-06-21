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
    @Published var calendar = Calendar.current
    
    func dateDifference(_ dateEnd: Date) -> Int {
        let component = calendar.dateComponents([.day], from: currentDate, to: dateEnd)
        return component.day ?? 0
    }
    
    func dateInterval(_ dateEnd: Date) -> Date {
        let interval = calendar.dateInterval(of: Calendar.Component.month, for: dateEnd)
        let start = interval?.start
        0r0eturn start ?? Date.now
    }
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
                Text("Разница дат \(viewModel.dateDifference(place.deteEnd))")
                    .foregroundColor(.red)
                Text("Интервал дат \(viewModel.dateInterval(place.deteEnd))")
            }
        }
    }
}

struct NoficationView_Previews: PreviewProvider {
    static var previews: some View {
        NoficationView()
    }
}
