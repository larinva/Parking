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
        return (component.day ?? 0)
    }
    
    func dateInterval(_ dateEnd: Date) -> Date {
        let interval = calendar.dateInterval(of: .day, for: dateEnd)?.end
//        let start = interval?.start
        return interval ?? Date.now
    }
    
    func dateInterval0(_ dateEnd: Date) -> Date {
        let interval = calendar.date(bySetting: .day, value: 1, of: dateEnd)
        return interval ?? Date.now
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
                Text("Дата нач \(place.dete.datemenu)")
                Text("Дата кон \(place.deteEnd.datemenu)")
                Text("Разница дат \(viewModel.dateDifference(place.deteEnd))")
                    .foregroundColor(.red)
                Text("Интервал дат \(viewModel.dateInterval0(place.deteEnd))")
                    .foregroundColor(.green)
            }
        }
    }
}

struct NoficationView_Previews: PreviewProvider {
    static var previews: some View {
        NoficationView()
    }
}
