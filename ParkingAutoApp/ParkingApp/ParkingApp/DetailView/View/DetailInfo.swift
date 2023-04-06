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
    var statusArenda: Bool
    
    //MARK: ViewModel
    @StateObject var cardDetailViewModel = CardDetailViewModel()
    
    var body: some View{
            Form{
                ProfileFotoView(title: idPlace)
                CardDetailView()
                //DatePickerView(model: cardDetailViewModel)
            }
        WriteCardDetailView()
    }
}

extension DetailInfo{
    @ViewBuilder
    private func CardDetailView()-> some View{
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
    private func WriteCardDetailView()->some View{
        HStack{
            arendaPlaceButton(isArenda: false, color: .red)
            .overlay {
                isComplete()
            }
            
            if !statusArenda{
                arendaPlaceButton(isArenda: true, color: .green)
                .overlay {
                    isExtend()
                }
            }
        }
        .padding()
    }
    
    private func arendaPlaceButton(isArenda: Bool, color: Color)->some View{
        Button{
            if isArenda {
                filterPlace(isArenda: isArenda)
                addItem()
            } else{
                filterPlace(isArenda: isArenda)
            }
        } label: {
            Capsule(style: .circular)
                .fill(color)
                .frame(width: size.width * 0.40, height: 40)
        }
    }
    
    private func isExtend()-> some View{
        return VStack{
            if cardDetailViewModel.isHiddenLabel(id: idPlace, parking: parking){
                Text("Арендовать")
                    .foregroundColor(.white)
            } else{
                Text("Продлить")
                    .foregroundColor(.white)
            }
        }
    }
    
    private func isComplete()-> some View{
        return VStack{
            Text("Завершить")
                .foregroundColor(.white)
        }
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
