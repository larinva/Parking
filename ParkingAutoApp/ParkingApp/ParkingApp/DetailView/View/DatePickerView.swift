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
    @StateObject var model = CardDetailViewModel()
    
    
    //MARK: Date
    @Environment(\.calendar) private var calendar
    
    private var startDate: Date{
        let date = calendar.startOfDay(for: Date.now)
        return date
    }
    
    private var endDate: Date{
        let end = model.data.dateEnd
        return end
    }
    
    @State private var date3 = Date.now
    
//    //MARK: Payment
//    @State private var price = ""
    
    var body: some View {
        Section(header: Text("Период парковки")){
//            DatePicker ("Оплачено c ", selection: .init(projectedValue: Date.now), in: Date()..., displayedComponents: .date)
//                .onChange(of: startDate) { newValue in
//                    model.data.date = newValue
//                }
//
            DatePicker ("Оплачено до ", selection: $model.data.dateEnd, in: Date()..., displayedComponents: .date)
                .onChange(of: endDate) { newValue in
                    model.data.date = startDate
                    model.data.dateEnd = newValue
                    date3 = newValue
                    PaymentView(date1: startDate, date2: endDate).generateDate(dateStart: startDate, dateEnd: newValue)
                }
        }
        
        PaymentView(date1: startDate, date2: date3)
    }
}

extension DatePickerView{
//    func generateDate(dateStart: Date, dateEnd: Date) -> () {
//        var dateComponent = calendar.dateComponents([.day], from: dateStart, to: dateEnd)
//        dateComponent.timeZone = .current
//
//        let monyDay = ((dateComponent.day ?? 0))
////        price = String((monyDay) * 100)
//    }
}
