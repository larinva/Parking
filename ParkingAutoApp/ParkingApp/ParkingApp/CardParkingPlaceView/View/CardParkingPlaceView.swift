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
    
    var id: String
    var isStatusArenda: Bool
    var isCancelButton: Bool?

    //MARK: ViewModel
    @StateObject var parkingViewModel = ParkingViewModel()

    var body: some View{
        ToolbarView
            Form{
                ProfileFotoView(idplace: id, isStatus: isStatusArenda)
                CardClientFormView(idplace: id, isStatus: isStatusArenda, viewModel: parkingViewModel)
                DatePickerView(viewModel: parkingViewModel)
            }
        WriteCardDetailView
    }
}

extension CardParkingPlaceView{
    private var ToolbarView: some View{
        ZStack{
            if isCancelButton ?? true{
                HStack{
                    Button() {
                        dismiss()
                    } label: {
                        Text("Отмена")
                    }

                    Spacer()

                    if isStatusArenda {
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
    private var WriteCardDetailView: some View{
        HStack{
            if isStatusArenda{
                arendaPlaceButton(isArenda: false, color: .red)
                    .overlay {
                        parkingCancelAlert
                            .foregroundColor(.white)
                    }
                arendaPlaceButton(isArenda: false, color: .green)
                    .overlay {
                        rentextendText
                    }
                
            } else {
                arendaPlaceButton(isArenda: true, color: .green)
                    .overlay {
                        rentextendText
                    }
            }
        }
        .padding()
    }
    
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
    
    private var rentextendText: some View{
        return VStack{
            if parkingViewModel.getStatusRent(idplace: id, context: viewContext){
                Text("Продлить")
                    .foregroundColor(.white)
            } else{
                Text("Арендовать")
                    .foregroundColor(.white)
            }
        }
    }
    
    private var parkingCancelAlert: some View{
        return VStack{
            Button("Завершить") {
                isAlert = true
            }
            .alert(Text("Внимание"), isPresented: $isAlert, actions: {
                Button("Завершить") {
                    setStatusRent(isArenda: false)
                }
                Button("Отмена", role: .cancel){}
            }, message: {
                Text("Вы действительно хотите завершить аренду")
            })
        }
    }
}


