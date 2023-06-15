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
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(fetchRequest: Parking.fetchRequest0(.all)) var parking: FetchedResults<Parking>
    
    @State private var isAlert: Bool = false
    @State private var searchText = ""
    
    var id: String
    var isStatusArenda: Bool
    var isCancelButton: Bool?

    //MARK: ViewModel
    @ObservedObject var parkingViewModel = ParkingViewModel()

    var body: some View{
        ToolbarView
            Form{
                ProfileFotoView(
                    idplace: id,
                    isStatus: isStatusArenda)

                CardClientFormView(idplace: id, viewModel: parkingViewModel)
                DatePickerView(viewModel: parkingViewModel)

//                let _ = print("JJJJJJJJJJJJJJJJJJJJJJJJJ \(parkingViewModel.getStatusRent(idplace: id, context: viewContext))")
//                let _ = print("AAAAAAAAAAAAAAAAAAAAAAAAA \(filterPlaceId(idPlace: id, parking: parking))")
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
    
    private func arendaPlace()-> some View{
        HStack{
            if isStatusArenda == false{
                arendaPlaceButton(isArenda: true, color: .green)
                    .overlay {
                        rentextendText(true)
                    }
            } else{
                arendaPlaceButton(isArenda: false, color: .red)
                    .overlay {
                        parkingCancelAlert()
                    }
                arendaPlaceButton(isArenda: isStatusArenda, color: .green)
                    .overlay {
                        rentextendText(isStatusArenda)
                    }
        }
        }
    }

    @ViewBuilder
    /*private func WriteCardDetailView()-> some View{
        HStack{
            if isStatusArenda{
                arendaPlaceButton(isArenda: false, color: .red)
                    .overlay {
                        parkingCancelAlert
                            .foregroundColor(.white)
                    }
                arendaPlaceButton(isArenda: false, color: .green)
                    .overlay {
                        rentextendText()
                    }
                let _ = print("WriteCardDetailView() true")
            }
            else {
                arendaPlaceButton(isArenda: true, color: .green)
                    .overlay {
                        rentextendText()
                    }
                let _ = print("WriteCardDetailView() false")
            }
        }
        .padding()
    }*/
    
    private func arendaPlaceButton(isArenda: Bool, color: Color)->some View{
        Button{
            if isArenda {
                setStatusRent(isArenda: isArenda)
                let _ = print("добавить \(isArenda)")
//                addData()
            } else{
//                setStatusRent(isArenda: isArenda)
                // продлить аренду парковочного места
                let _ = print("no add \(isArenda)")
            }
        } label: {
            Capsule(style: .circular)
                .fill(color)
                .frame(width: size.width * 0.40, height: 40)
        }
    }
    
    private func rentextendText(_ status: Bool)-> some View{
        return VStack{
            if status{
                let _ = print("продлить")
                Text("Продлить")
                    .foregroundColor(.white)
            } else{
                let _ = print("арендовать")
                Text("Арендовать")
                    .foregroundColor(.white)
            }
        }
    }
    
    private func parkingCancelAlert()-> some View{
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
