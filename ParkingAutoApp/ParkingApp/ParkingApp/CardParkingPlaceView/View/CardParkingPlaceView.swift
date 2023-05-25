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
    @Environment(\.editMode) private var editMode
    
    //Core Data
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: Parking.fetchRequest0()) private var parking: FetchedResults<Parking>
    
    @State private var isAlert: Bool = false
   
    var idPlace: String
    var isStatusArenda: Bool
    var isCancelButton: Bool?
   
    private let imageSize: CGFloat = 22
    
    private let arendaText = "Арендовать"
    private let stopText = "Завершить"
    private let warningText = "Внимание"
    private let cancelText = "Отмена"
    private let extendText = "Продлить"
    private let messageText = "Вы действительно хотите завершить аренду"
    private let clientsCardText = "Карточка клиента"
    
    private let cancelImage = "multiply.circle.fill"
    private let personImage = "person"
    
    //MARK: ViewModel
    @StateObject var cardDetailViewModel = CardParkingPlaceViewModel()

    var body: some View{
        if isCancelButton ?? true{
            toolbarView()
        }
        
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
        Section(header: Text(clientsCardText)){

            if isStatusArenda == true && editMode?.wrappedValue.isEditing == false{
                let _ = print("yes")
                downFormView()
                
            }else{
                editFormView()
            }
        }
        .onAppear{
            cardDetailViewModel.loadArendaPlace(
                idplace: idPlace,
                place: parking
            )
        }
    }
    
    private func toolbarView()-> some View{
        HStack{
            Button() {
                dismiss()
            } label: {
                Text("Отмена")
            }
            
            Spacer()
            
            if isStatusArenda == true {
                if editMode?.wrappedValue == .inactive{
                    Button("Править") {
                        editMode?.wrappedValue = .active
                        let _ = print("tap")
                    }
                } else {
                    Button("Готово") {
                        //editMode?.wrappedValue = .active
                        let _ = print("Save")
                        saveData()
                    }
                }
                
                //EditButton()
            } else {
                Button("1111") {
                    //editMode?.wrappedValue = .active
                    let _ = print("11111")
                }
            }
        }
        .padding([.leading, .trailing, .top], 16)
    }
    
    private func editFormView()-> some View{
        return VStack{
            HStack{
                Image(systemName: personImage)
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                    .foregroundColor(.gray)
                
            TextField(PersonData.ovnerAuto, text: $cardDetailViewModel.data.ovnerAuto)
        }
        
        HStack{
            Image(systemName: "phone.circle")
                .resizable()
                .frame(width: imageSize, height: imageSize)
                .foregroundColor(.gray)
            
            TextField(PersonData.numberFone, text: cardDetailViewModel.maskPhoneBinding())
                .keyboardType(.numberPad)
                .onAppear{
                    cardDetailViewModel.loadNumberFone()
                }
        }
        
        HStack{
            Image(systemName: "car")
                .resizable()
                .frame(width: imageSize, height: imageSize)
                .foregroundColor(.gray)
            TextField(PersonData.carBrand, text: $cardDetailViewModel.data.carBrand)
        }
        
        HStack{
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: imageSize, height: imageSize)
                .foregroundColor(.gray)
            TextField(PersonData.numberAuto, text:
                        $cardDetailViewModel.data.numberAuto)
        }
        }
    }
    
    private func downFormView()-> some View{
        return VStack{
            TextField("", text: $cardDetailViewModel.data.ovnerAuto)
            TextField("", text: $cardDetailViewModel.data.numberFone)
            TextField("", text: $cardDetailViewModel.data.carBrand)
            TextField("", text: $cardDetailViewModel.data.numberAuto)
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

// MARK: Core Data

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
    
    private func saveData(){
        cardDetailViewModel.saveCoreData(id: idPlace, context: viewContext)
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
