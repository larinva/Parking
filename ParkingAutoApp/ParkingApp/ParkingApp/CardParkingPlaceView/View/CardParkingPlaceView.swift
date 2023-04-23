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
    @FetchRequest(fetchRequest: Parking.fetchRequest0()) private
    var parking: FetchedResults<Parking>
    var idPlace: String
    var isStatusArenda: Bool
    
    let widthStroke: CGFloat = 1
   
    @State private var isAlertw: Bool = false
    
    //MARK: ViewModel
    @StateObject var cardDetailViewModel = CardParkingPlaceViewModel()
    
    let maskPhone = "+X-XXX-XXX-XX-XX"
    @State private var text = ""
    
    var maskPhoneW: Formatter{
        let formatter = Formatter()
        let mask = FilterNumberPhone.format(with: maskPhone, phone: text)
        formatter.editingString(for: mask)
//        formatter.string(for: mask)
        return formatter
    }
    
    @State private var score = 0

        let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()
    
    var body: some View{
            Form{
                ProfileFotoView(title: idPlace, status: isStatusArenda)
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
            TextField("Имя владельца", text: $cardDetailViewModel.data.ovnerAuto)
            TextField("Номер телефона", text: $cardDetailViewModel.data.numberFone)
                .keyboardType(.numberPad)
//            let _ = print(maskPhoneW)
//            NumberPhoneMaskView()
//                .frame(height: 50)
//                .padding([.all], widthStroke / 2)
//                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.purple, lineWidth: widthStroke))
//                .padding()
            
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

            if !isStatusArenda{
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
        .alert(isPresented: $isAlertw) {
            Alert(title: Text("1234654"), message: Text("12316454"))
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
