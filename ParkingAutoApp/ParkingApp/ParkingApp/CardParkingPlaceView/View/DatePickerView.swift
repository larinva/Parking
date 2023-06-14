//
//  DatePickerView.swift
//  ParkingApp
//
//  Created by vacheslavBook on 25.03.2023.

import SwiftUI

struct DatePickerView: View {
    //Core Data
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(fetchRequest: Parking.fetchRequest0(.all)) var parking: FetchedResults<Parking>
    
    //MARK: ViewModel
    @StateObject var viewModel: ParkingViewModel
    
    @State private var isPicker: Bool = false
    

    var body: some View {
        Section(header: Text("Период парковки")){
            if isPicker{
                NextDayMonthView
            } else{
                DatePayView
            }
        }
        TogglePayView
    }
}

extension DatePickerView{
    private var startDate: Date{
         let date = viewModel.calendar.startOfDay(for: Date.now)
         return date
     }
    
    private var endDate: Date{
        let end = viewModel.data.dateEnd
        return end
    }

    private var NextDayMonthView: some View {
        HStack{
            Text("Оплачено до ")
            Spacer()
            VStack{
                Text("\(viewModel.nextDayMonth)")
            }
            .edgesIgnoringSafeArea(.all)
            .foregroundColor(.primary)
                .padding([.horizontal], 12)
                .padding(.vertical, 6)
                .background(.gray.opacity(0.2))
                .cornerRadius(5)
        }
    }
    
    private var DatePayView: some View {
        return DatePicker ("Оплачено до ", selection: isPicker ? $viewModel.datePicker : $viewModel.data.dateEnd, displayedComponents: .date)
        .onChange(of: endDate) { newValue in
            viewModel.data.date = startDate
            viewModel.data.dateEnd = newValue
            viewModel.price = viewModel.payOfMonth
            viewModel.payByDay(dateStart: startDate, dateEnd: newValue)
        }
    }
    
    private var TogglePayView: some View{
        Section(header: Text("Оплата")){
            Text("\(viewModel.price)")
            
            Toggle(isOn: $isPicker){
                Text("Оплата за месяц")
            }
            .onChange(of: isPicker) { newValue in
                if isPicker{
                    viewModel.price = viewModel.payOfMonth
                    viewModel.data.isDatePicker = newValue
                } else{
                    viewModel.payByDay(dateStart: startDate, dateEnd: endDate)
                    viewModel.datePicker = startDate
                }
            }
            .onAppear{
                isPicker = viewModel.data.isDatePicker
            }
        }
    }
}
