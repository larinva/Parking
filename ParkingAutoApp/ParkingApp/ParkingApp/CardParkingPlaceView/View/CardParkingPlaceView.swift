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

struct CardParkingPlaceView: View {
    @Environment(\.dismiss) private var dismiss
    
    //Core Data
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: Parking.fetchRequest0()) private var parking: FetchedResults<Parking>
    
    @State private var isAlert: Bool = false
    
    var idPlace: String
    var isStatusArenda: Bool
    private let imageSize: CGFloat = 22
    
    private let arendaText = "Арендовать"
    private let stopText = "Завершить"
    private let warningText = "Внимание"
    private let cancelText = "Отмена"
    private let extendText = "Продлить"
    private let messageText = "Вы действительно хотите завершить аренду"
    
    //MARK: ViewModel
    @StateObject var cardDetailViewModel = CardParkingPlaceViewModel()

    var body: some View{
            Form{
                ProfileFotoView(title: idPlace, isStatus: isStatusArenda)
                InfoClientSectionView()
                DatePickerView(model: cardDetailViewModel)
            }
        WriteCardDetailView()
    }
}

extension CardParkingPlaceView{
    @ViewBuilder
    private func InfoClientSectionView()-> some View{
        Section(header: Text("Карточка клиента")){
            HStack{
                Image(systemName: "person")
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                TextField("Имя владельца", text: $cardDetailViewModel.data.ovnerAuto)
            }
            
            HStack{
                Image(systemName: "phone.circle")
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                TextField("Номер телефона", text: cardDetailViewModel.maskPhoneBinding())
                    .keyboardType(.numberPad)
            }
            
            HStack{
                Image(systemName: "car")
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                TextField("Марка машины", text: $cardDetailViewModel.data.carBrand)
            }
            
            HStack{
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                TextField("Гос. номер авто", text:
                            $cardDetailViewModel.data.numberAuto)
            }
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
                    iaAlert()
                        .foregroundColor(.white)
                }
                
            if !isStatusArenda{
                arendaPlaceButton(isArenda: true, color: .green)
                    .overlay {
                        isExtend()
                    }
            }
        }
        .padding()
    }
    
    @ViewBuilder
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
                Text(arendaText)
                    .foregroundColor(.white)
            } else{
                Text(extendText)
                    .foregroundColor(.white)
            }
        }
    }
    
    private func iaAlert()->some View{
        return VStack{
            Button(stopText) {
                isAlert = true
            }
            .alert(Text(warningText), isPresented: $isAlert, actions: {
                Button(stopText) {
                    filterPlace(isArenda: false)
                }
                Button(cancelText, role: .cancel){}
            }, message: {
                Text(messageText)
            })
        }
    }
}

extension CardParkingPlaceView{
    
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
