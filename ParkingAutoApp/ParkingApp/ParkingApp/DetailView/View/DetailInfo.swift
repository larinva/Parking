//
//  DetailInfo.swift
//  ParkingApp
//
//  Created by vacheslavBook on 21.01.2023.

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
    var idPlace: String
    
    //MARK: ViewModel
    @StateObject var cardDetailViewModel = CardDetailViewModel()
    
//    //MARK: Date
//    @Environment(\.calendar) private var calendar
//    @State private var startDate = Date.now
//     private var endDate: Date{
//        let end = cardDetailViewModel.data.dateEnd
//        return end
//    }
    

    
//    //MARK: Payment
//    @State private var price = ""
    
    var body: some View{
            Form{
                ProfileFotoView(title: idPlace)
                cardDetailView()
//                dateDetailView()
                DatePickerView(model: cardDetailViewModel)
//                PaymentDetailView()
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
    
//    @ViewBuilder
//    private func dateDetailView()-> some View{
//        Section(header: Text("Период парковки")){
//            DatePicker ("Оплачено c ", selection: $startDate, in: Date()..., displayedComponents: .date)
//                .onChange(of: startDate) { newValue in
//                    cardDetailViewModel.data.date = newValue
//                }
//            
//            DatePicker ("Оплачено до ", selection: $cardDetailViewModel.data.dateEnd, in: Date()..., displayedComponents: .date)
//                .onChange(of: endDate) { newValue in
//                    //endDate = newValue
//                    //print(newValue)
//                    let _ = print("\(endDate)")
//                    cardDetailViewModel.data.dateEnd = newValue
//                    generateDate(dateStart: calendar.startOfDay(for: startDate), dateEnd: newValue)
//                }
//        }
//    }
//    
//    func generateDate(dateStart: Date, dateEnd: Date) -> () {
//        var diffs = calendar.dateComponents([.day], from: dateStart, to: dateEnd)
//        diffs.timeZone = .current
//
//        let _ = print((diffs.day ?? 0))
//        
//        let monyDay = ((diffs.day ?? 0))
//        price = String((monyDay) * 100)
//    }
    
//    @ViewBuilder
//    private func paymentDetailView()-> some View{
//        Section(header: Text("Оплата")){
//            TextField("Стоимость", text: $price)
//        }
//    }
    
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
