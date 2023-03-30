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

    private var startDate: Date{
        let date = model.calendar.startOfDay(for: Date.now)
        return date
    }
    
    private var endDate: Date{
        let end = model.data.dateEnd
        return end
    }
    
    @State private var dddd = Date.now
    
    var body: some View {
        
        Section(header: Text("Период парковки")){
//            DatePicker ("Оплачено c ", selection: .init(projectedValue: Date.now), in: Date()..., displayedComponents: .date)
//                .onChange(of: startDate) { newValue in
//                    model.data.date = newValue
//                }
//
            if !model.isPicker{
                DatePicker ("Оплачено до ", selection: $model.data.dateEnd, in: Date()..., displayedComponents: .date)
                    .onChange(of: endDate) { newValue in
                        model.data.date = startDate
                        model.data.dateEnd = newValue
                        model.generateDate(dateStart: startDate, dateEnd: newValue)
                    }
            }
            else{
                DatePicker ("Оплачено до ", selection: $dddd , in: Date()..., displayedComponents: .date)
                    .onChange(of: endDate) { newValue in
                        model.data.date = startDate
                        model.data.dateEnd = newValue
                        model.generateDate(dateStart: startDate, dateEnd: newValue)
                    }
            }
        }
        Pay()
    }
    
    
    func Pay() -> some View{
        Section(header: Text("Оплата")){
            Text("\(model.price)")
            
            Toggle(isOn: $model.isPicker){
                Text("Оплата за месяц")
                Text("\(model.paymentMonth())")
            }
            .onChange(of: model.isPicker) { newValue in
                dddd = model.paymentMonth()
                if model.isPicker{
                    model.payOfMonth()
                } else{
                    model.price = "0"
                }
            }
        }
    }
}
