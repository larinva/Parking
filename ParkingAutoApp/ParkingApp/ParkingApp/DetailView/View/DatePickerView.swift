//
//  DatePickerView.swift
//  ParkingApp
//
//  Created by vacheslavBook on 25.03.2023.
//

import SwiftUI

struct DatePickerView: View {
    //Core Data
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: Parking.fetchRequest0()) private
    var parking: FetchedResults<Parking>
    
    //MARK: ViewModel
    @StateObject var model: CardDetailViewModel
    
    
    //MARK: Date
    @Environment(\.calendar) private var calendar
    @State private var startDate = Date.now
    
    private var endDate: Date{
        let end = model.data.dateEnd
        return end
    }
    
    //MARK: Payment
    @State private var price = ""
    
    var body: some View {
        Section(header: Text("Период парковки")){
            DatePicker ("Оплачено c ", selection: $startDate, in: Date()..., displayedComponents: .date)
                .onChange(of: startDate) { newValue in
                    model.data.date = newValue
                }
            
            DatePicker ("Оплачено до ", selection: $model.data.dateEnd, in: Date()..., displayedComponents: .date)
                .onChange(of: endDate) { newValue in
                    model.data.dateEnd = newValue
                    generateDate(dateStart: calendar.startOfDay(for: startDate), dateEnd: newValue)
                }
        }
        
        PaymentDetailView(price: price)
    }
}

extension DatePickerView{
    func generateDate(dateStart: Date, dateEnd: Date) -> () {
        var dateComponent = calendar.dateComponents([.day], from: dateStart, to: dateEnd)
        dateComponent.timeZone = .current

        let monyDay = ((dateComponent.day ?? 0))
        price = String((monyDay) * 100)
    }
}
