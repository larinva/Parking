//
//  DetailInfo.swift
//  ParkingApp
//
//  Created by vacheslavBook on 21.01.2023.


import SwiftUI

let size = UIScreen.main.bounds


enum StatusRent{
    case rent
    case free
}

struct CardParkingPlaceView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.editMode) private var editMode
    
    //Core Data
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(fetchRequest: Parking.fetchRequest0(.all)) var parking: FetchedResults<Parking>
    
    @State private var isAlert: Bool = false
    @State private var searchText = ""
    @State private var statusRent: StatusRent = .rent
    
    var id: String
    var isStatusArenda: Bool
    var isCancelButton: Bool?

    //MARK: ViewModel
    @StateObject var parkingViewModel = ParkingViewModel()

    var body: some View{
        ToolbarView
            Form{
                ProfileFotoView(
                    idplace: id,
                    isStatus: isStatusArenda)
                CardClientFormView(
                    idplace: id,
                    viewModel: parkingViewModel)
                DatePickerView(
                    viewModel: parkingViewModel)

            }
//        WriteCardDetailView()
        
        arendaPlace()
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
    private func arendaPlace()-> some View{
        HStack{
            switch isStatusArenda{
            case true:
                arendaPlaceButton(isArenda: false, color: .red)
                    .overlay {
                        parkingCancelAlert
                    }
                arendaPlaceButton(isArenda: false, color: .green)
                    .overlay {
                        rentextendText
                    }
            case false:
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
            switch !isArenda{
            case true:
                setStatusRent(isArenda: false)
                let _ = print("true000 \(isArenda)")
            case false:
                //setStatusRent(isArenda: isArenda)
                addData()
                // продлить аренду парковочного места
                let _ = print("false00 \(true)")
            }
        } label: {
            Capsule(style: .circular)
                .fill(color)
                .frame(width: size.width * 0.40, height: 40)
        }
    }
    
    private var rentextendText: some View{
        return VStack{
            if isStatusArenda{
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


//parkingViewModel.getStatusRent(idplace: id, context: viewContext)
