//
//  DetailInfo.swift
//  ParkingApp
//
//  Created by vacheslavBook on 21.01.2023.
//
// клонирование на GitHub первое приложение
// второй репозиторий для тестирования гитхаба
// третье обновление репозиторя для теста
// четвертое обновление
// пятое обновление

import SwiftUI

let size = UIScreen.main.bounds

func filterPlaceId(idPlace: String, parking: FetchedResults<Parking>)-> [FetchedResults<Parking>.Element]{
    let filter = parking.filter{ $0.idPlace == idPlace }
    return filter
}


struct DetailInfo: View {
    @Environment(\.dismiss) private var dismiss
    //Core Data
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: Parking.fetchRequest0()) private
    var parking: FetchedResults<Parking>
    var idPlace: String = ""
    
    //MARK: ViewModel
    @StateObject var cardDetailViewModel = CardDetailViewModel()
    
    //MARK: Date
    @State private var startDate = Date.now
    @State private var endDate = {
        var date = Calendar.current.date(byAdding: .day, value: 30, to: Date())
        
        return date
    }()
    
    @State private var dates: Set<DateComponents> = []
    @State private var datesComponent: DateComponents = DateComponents()
    
    @Environment(\.calendar) private var calendar
    
    let components = Calendar.current.dateComponents([.day],
                                                     from: Date.now)
    
    init(){
        generateDate()
        
    }
    
    //MARK: Payment
    @State private var price = ""
    
    var body: some View{
            Form{
                ProfileFotoView(title: idPlace)
                cardDetailView()
                dateDetailView()
                paymentDetailView()
            }
        writeCardDetailView()
    }
}

extension DetailInfo{
    @ViewBuilder
    private func cardDetailView()-> some View{
        Section(header: Text("Карточка клиента")){
            TextField("Имя владельца", text: $cardDetailViewModel.data.ovnerAuto)
            TextField("Номер телефона", text: $cardDetailViewModel.data.numberFone)
            TextField("Марка машины", text: $cardDetailViewModel.data.carBrand)
            TextField("Гос. номер авто", text: $cardDetailViewModel.data.numberAuto)
        }
        .onAppear{
            cardDetailViewModel.loadArendaPlace(
                idplace: idPlace,
                place: parking
            )
        }
    }
    
    @ViewBuilder
    private func dateDetailView()-> some View{
        Section(header: Text("Период парковки")){
            DatePicker ("Оплачено до ", selection: $startDate, in: Date()..., displayedComponents: .date)
//            MultiDatePicker("Оплачено до ", selection: $dates)
//            let nextDate = Calendar.current.nextDate(
//                after: Date.now,
//                matching: components,
//                matchingPolicy: .nextTime,
//                repeatedTimePolicy: .first,
//                direction: .forward)
            
//            let today = Date()
//            let date = Calendar.current.date(
//                from: DateComponents(timeZone: TimeZone(abbreviation: "GMT"),
//                year: 2021, month: 8, day: 2))!
//            date.distance(to: today)
//
//            let _ = print(date)
        }
    }
    
    func generateDate() -> () {
        let today = Date()
        let date = Calendar.current.date(
            from: DateComponents(timeZone: TimeZone(abbreviation: "GMT"),
            year: 2023, month: 03, day: 25))!
        let tim = date.distance(to: today)
        
        let _ = print(date)
    }
    
    @ViewBuilder
    private func paymentDetailView()-> some View{
        Section(header: Text("Оплата")){
            TextField("Стоимость", text: $price)
        }
    }
    
    @ViewBuilder
    private func writeCardDetailView()->some View{
        HStack{
            Button{
                filterPlace(isArenda: false)
            } label: {
                Capsule(style: .circular)
                    .fill(.red)
                    .frame(width: size.width * 0.40, height: 40)
            }
            .overlay {
                Text("Завершить")
                    .foregroundColor(.white)
            }
            
            Button{
                filterPlace(isArenda: true)
                addItem()
                dismiss()
            } label: {
                Capsule(style: .circular)
                    .fill(.green)
                    .frame(width: size.width * 0.40, height: 40)
            }
            .overlay {
                if cardDetailViewModel.isHiddenLabel(id: idPlace, parking: parking){
                    Text("Арендовать")
                        .foregroundColor(.white)
                } else{
                    Text("Продлить")
                        .foregroundColor(.white)
                }
            }
        }
        .padding()
    }
}

extension DetailInfo{
    private func filterPlace(isArenda: Bool){
        for item in filterPlaceId(idPlace: idPlace, parking: parking){
            item.isArenda = isArenda
            item.places_?.isArenda = isArenda
            viewContext.saveContext()
        }
    }
    
    private func addItem(){
        withAnimation {
            cardDetailViewModel.addItem(
                idplace: idPlace,
                detailViewModel: cardDetailViewModel,
                context: viewContext
            )
        }
    }
    
    private func deleteItem(){
        withAnimation {
            cardDetailViewModel.deleteAllItem(
                parking: parking,
                context: viewContext
            )
        }
    }
}
