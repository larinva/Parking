//
//  DatePiickerViewExtension.swift
//  ParkingApp
//
//  Created by Вячеслав Ларин on 05.05.2023.
//

import SwiftUI

extension DatePickerView{
    func NextDayMonthView() -> some View {
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
    }
    
    func DatePayView() -> some View {
        DatePicker ("Оплачено до ", selection: model.isPicker ? $model.datePicker : $model.data.dateEnd, displayedComponents: .date)
        .onChange(of: endDate) { newValue in
            model.data.date = startDate
            model.data.dateEnd = newValue
            model.price = model.payOfMonth()
            model.payByDay(dateStart: startDate, dateEnd: newValue)
            //let _ = print(newValue)
        }
    }
    
    func TogglePayView() -> some View{
        Section(header: Text("Оплата")){
            Text("\(model.price)")
            
            Toggle(isOn: $model.isPicker){
                Text("Оплата за месяц")
            }
            .onChange(of: model.isPicker) { newValue in
                if model.isPicker{
                    model.price = model.payOfMonth()
                } else{
                    model.payByDay(dateStart: startDate, dateEnd: endDate)
                    model.datePicker = startDate
                }
            }
            .onAppear{
                //model.isPicker = model.data.isDatePicker
            }
        }
    }
}
