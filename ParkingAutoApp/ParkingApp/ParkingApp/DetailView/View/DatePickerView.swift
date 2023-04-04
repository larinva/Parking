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
    
    @State private var datePicker = Date.now
    
    var body: some View {
        
        Section(header: Text("Период парковки")){
//            DatePicker ("Оплачено c ", selection: .init(projectedValue: Date.now), in: Date()..., displayedComponents: .date)
//                .onChange(of: startDate) { newValue in
//                    model.data.date = newValue
//                }

            DatePicker ("Оплачено до ", selection: model.isPicker ? $model.datePicker : $model.data.dateEnd, in: Date()..., displayedComponents: .date)
                .onChange(of: endDate) { newValue in
                    model.data.date = startDate
//                    model.data.dateEnd = newValue
//                    print("0000000000000000 \(model.data.dateEnd)")
                    model.price = model.payOfMonth()
//                    model.data.isDatePicker = model.isPicker
                    model.payByDay(dateStart: startDate, dateEnd: newValue)
                }
        }
        TogglePayView()
    }
    
    
    func TogglePayView() -> some View{
        Section(header: Text("Оплата")){
            Text("\(model.price)")
            
            Toggle(isOn: $model.isPicker){
                Text("Оплата за месяц")
                Text("\(model.nextDayMonth())")
            }
            .onChange(of: model.isPicker) { newValue in
                if model.isPicker{
                    model.datePicker = model.nextDayMonth()
                    model.price = model.payOfMonth()
                    model.data.dateEnd = model.nextDayMonth()
                } else{
                    model.payByDay(dateStart: startDate, dateEnd: endDate)
                }
            }
            .onAppear{
                model.isPicker = model.data.isDatePicker
            }
        }
    }
}
