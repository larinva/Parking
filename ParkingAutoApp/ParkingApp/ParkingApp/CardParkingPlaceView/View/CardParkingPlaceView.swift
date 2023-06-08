//
//  DetailInfo.swift
//  ParkingApp
//
//  Created by vacheslavBook on 21.01.2023.


import SwiftUI

let size = UIScreen.main.bounds


struct CardParkingPlaceView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.editMode) private var editMode
    
    //Core Data
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(fetchRequest: Parking.fetchRequest0(.all)) var parking: FetchedResults<Parking>
    
    @State private var isAlert: Bool = false
    @State private var searchText = ""
    
    var idPlace: String
    var isStatusArenda: Bool?
    var isCancelButton: Bool?

    private let arendaText = "Арендовать"
    private let stopText = "Завершить"
    private let warningText = "Внимание"
    private let cancelText = "Отмена"
    private let extendText = "Продлить"
    private let messageText = "Вы действительно хотите завершить аренду"
    
    private let cancelImage = "multiply.circle.fill"
    
    //MARK: ViewModel
    @StateObject var parkingViewModel = ParkingViewModel()

    var body: some View{
        ToolbarView()
            Form{
                ProfileFotoView(idPlace: idPlace, isStatus: isStatusArenda ?? false ? true : false)
                CardClientFormView(parkingViewModel: parkingViewModel, id: idPlace)
                DatePickerView(parkingViewModel: parkingViewModel)
            }
        WriteCardDetailView()
    }
}

extension CardParkingPlaceView{
    private func ToolbarView()-> some View{
        ZStack{
            if isCancelButton ?? true{
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
                            }
                        } else {
                            Button("Готово") {
                                editMode?.wrappedValue = .inactive
                                saveData()
                            }
                        }
                    }
                }
                .padding([.leading, .trailing, .top], 16)
            }
        }
    }

    @ViewBuilder
    private func WriteCardDetailView()->some View{
        HStack{
            if (isStatusArenda ?? true){
                arendaPlaceButton(isArenda: false, color: .red)
                    .overlay {
                        iaAlert()
                            .foregroundColor(.white)
                    }
                arendaPlaceButton(isArenda: false, color: .green)
                    .overlay {
                        isExtend()
                    }
                
            } else {
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
                setStatusRent(isArenda: isArenda)
                addData()
            } else{
                setStatusRent(isArenda: isArenda)
            }
        } label: {
            Capsule(style: .circular)
                .fill(color)
                .frame(width: size.width * 0.40, height: 40)
        }
    }
    
    private func isExtend()-> some View{
        return VStack{
            if parkingViewModel.getStatusRent(id: idPlace, context: viewContext){
                Text(extendText)
                    .foregroundColor(.white)
            } else{
                Text(arendaText)
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
                    setStatusRent(isArenda: false)
                }
                Button(cancelText, role: .cancel){}
            }, message: {
                Text(messageText)
            })
        }
    }
}


