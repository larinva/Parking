//
//  DatePickerView.swift
//  ParkingApp
//
//  Created by vacheslavBook on 25.03.2023.

import SwiftUI

struct DatePickerView: View {
    //Core Data
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: Parking.fetchRequest0(.all)) private
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
    
    var paidToText = "Оплачено до "
    var paymentText = "Оплата"
    var paymentMonthText = "Оплата за месяц"
    var parkingPeriod = "Период парковки"
     
    var body: some View {
        
        Section(header: Text(parkingPeriod)){
            if model.isPicker{
                NextDayMonthView()
            } else{
                DatePayView()
            }
        }
        TogglePayView()
    }
}

