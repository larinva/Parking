//
//  DatePickerView.swift
//  ParkingApp
//
//  Created by vacheslavBook on 25.03.2023.

import SwiftUI

struct DatePickerView: View {
    var paidToText = "Оплачено до "
    var paymentText = "Оплата"
    var paymentMonthText = "Оплата за месяц"
    var parkingPeriod = "Период парковки"
    
    var startDate: Date{
        let date = parkingViewModel.calendar.startOfDay(for: Date.now)
        return date
    }
    
    var endDate: Date{

        let end = parkingViewModel.data.dateEnd
        return end
    }
    
    //Core Data
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(fetchRequest: Parking.fetchRequest0(.all)) var parking: FetchedResults<Parking>
    
    //MARK: ViewModel
    @StateObject var parkingViewModel: ParkingViewModel
    

    var body: some View {
        Section(header: Text(parkingPeriod)){
            if parkingViewModel.isPicker{
                NextDayMonthView()
            } else{
                DatePayView()
            }
        }
        TogglePayView()
    }
}

extension DatePickerView{
    func NextDayMonthView() -> some View {
        HStack{
            Text(paidToText)
            Spacer()
            VStack{
                Text("\(parkingViewModel.nextDayMonth())")
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
        DatePicker (paidToText, selection: parkingViewModel.isPicker ? $parkingViewModel.datePicker : $parkingViewModel.data.dateEnd, displayedComponents: .date)
        .onChange(of: endDate) { newValue in
            parkingViewModel.data.date = startDate
            parkingViewModel.data.dateEnd = newValue
            parkingViewModel.price = parkingViewModel.payOfMonth()
            parkingViewModel.payByDay(dateStart: startDate, dateEnd: newValue)
        }
    }
    
    func TogglePayView() -> some View{
        Section(header: Text(paymentText)){
            Text("\(parkingViewModel.price)")
            
            Toggle(isOn: $parkingViewModel.isPicker){
                Text(paymentMonthText)
            }
            .onChange(of: parkingViewModel.isPicker) { newValue in
                if parkingViewModel.isPicker{
                    parkingViewModel.price = parkingViewModel.payOfMonth()
                    parkingViewModel.data.isDatePicker = newValue
                } else{
                    parkingViewModel.payByDay(dateStart: startDate, dateEnd: endDate)
                    parkingViewModel.datePicker = startDate
                }
            }
            .onAppear{
                parkingViewModel.isPicker = parkingViewModel.data.isDatePicker
            }
        }
    }
}
