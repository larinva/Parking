//
//  DatePickerView.swift
//  ParkingApp
//
//  Created by vacheslavBook on 25.03.2023.

import SwiftUI

struct DatePickerView: View {
    //Core Data
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: Parking.fetchRequest0()) private
    var parking: FetchedResults<Parking>
    
    //MARK: ViewModel
    @StateObject var model = CardParkingPlaceViewModel()

    var startDate: Date{
        let date = model.calendar.startOfDay(for: Date.now)
        return date
    }
    
    var endDate: Date{
        let end = model.data.dateEnd
        return end
    }
     
    var body: some View {
        
        Section(header: Text("Период парковки")){
            if model.isPicker{
                NextDayMonthView()
            } else{
                DatePayView()
            }
        }
        TogglePayView()
    }
}

