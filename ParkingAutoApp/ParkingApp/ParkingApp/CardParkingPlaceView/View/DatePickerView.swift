//
//  DatePickerView.swift
//  ParkingApp
//
//  Created by vacheslavBook on 25.03.2023.
// update
// update 222
// update 23.04.23
// update 23.04.23
// update 23.04.23
// update 23.04.23

import SwiftUI

struct DatePickerView: View {
    //Core Data
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: Parking.fetchRequest0()) private
    var parking: FetchedResults<Parking>
    
    //MARK: ViewModel
    @StateObject var model = CardParkingPlaceViewModel()

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
            
            if model.isPicker{
                HStack{
                    Text("Оплачено до ")
                    Spacer()
                    VStack{
                        Text("\(model.nextDayMonth())")
                    }
                    .edgesIgnoringSafeArea(.all)
                    .foregroundColor(.primary)
                        .padding([.horizontal], 12)
                        .padding(.vertical, 6)
                        .background(.gray.opacity(0.2))
                        .cornerRadius(5)
                }
            } else{
                DatePicker ("Оплачено до ", selection: model.isPicker ? $model.datePicker : $model.data.dateEnd, in: Date()..., displayedComponents: .date)
                .onChange(of: endDate) { newValue in
                    model.data.date = startDate
                    model.data.dateEnd = newValue
//                    model.datePicker = startDate
//                    print(startDate)
                    model.price = model.payOfMonth()
                    model.payByDay(dateStart: startDate, dateEnd: newValue)
                }
        }
        }
        TogglePayView()
    }
    
    func TogglePayView() -> some View{
        Section(header: Text("Оплата")){
            Text("\(model.price)")
            
            Toggle(isOn: $model.isPicker){
                Text("Оплата за месяц")
            }
            .onChange(of: model.isPicker) { newValue in
                if model.isPicker{
//                    model.datePicker = model.nextDayMonth()
                    model.price = model.payOfMonth()
//                    model.data.dateEnd = model.nextDayMonth()
                } else{
                    model.payByDay(dateStart: startDate, dateEnd: endDate)
                    model.datePicker = startDate
                    print("off \(startDate)")
                }
            }
            .onAppear{
                model.isPicker = model.data.isDatePicker
            }
        }
    }
}
