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
    @FetchRequest(fetchRequest: Parking.fetchRequest0(.isArenda)) var parking: FetchedResults<Parking>
    
    @State private var isAlert: Bool = false
    @State private var searchText = ""
    @State private var statusRent: StatusRent = .rent
  
    var id: String
//    var isStatusArenda: Bool
    var isCancelButton: Bool?

    //MARK: ViewModel
    @StateObject var parkingViewModel = ParkingViewModel()

    var body: some View{
        ToolbarView
            Form{
                ProfileFotoView(
                    idplace: id,
                    isStatus: parkingViewModel.getStatusRent(idplace: id, context: viewContext))
                CardClientFormView(
                    idplace: id,
                    viewModel: parkingViewModel)
                DatePickerView(
                    viewModel: parkingViewModel)

            }
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

                    if parkingViewModel.getStatusRent(idplace: id, context: viewContext) {
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
            
//            let _ = print("ppppppppppppp \(parkingViewModel.getStatusRent(idplace: id, context: viewContext))")
//            let _ = print("parking \(parking)")
//
            Button{
                setStatusRent(isArenda: false)
            } label: {
                parkingCancelAlert
            }.buttonStyle(RedButtonStyle())

            Button{
                setStatusRent(isArenda: true)
//                addData()
            } label: {
                rentextendText
            }.buttonStyle(GreenButtonStyle())
//
//            switch isStatusArenda{
//            case true:
//                arendaPlaceButton(isArenda: false, color: .red)
//                    .overlay {
//                        parkingCancelAlert
//                    }
//                arendaPlaceButton(isArenda: false, color: .green)
//                    .overlay {
//                        rentextendText
//                    }
////                let _ = print("truearendaplace \(isStatusArenda)")
//            case false:
//                arendaPlaceButton(isArenda: true, color: .green)
//                    .overlay {
//                        rentextendText
//                    }
////                let _ = print("falsearendaplace \(isStatusArenda)")
//            }
        }
        .padding()
        .buttonStyle(.automatic)
    }

    /*private func arendaPlaceButton(isArenda: Bool, color: Color)->some View{
        Button{
//            let _ = print(parking)
            
//            if isArenda{
//                setStatusRent(isArenda: isArenda)
////                let _ = print("true000 \(isArenda)")
////                addData()
//            } else{
//                setStatusRent(isArenda: isArenda)
//
//                // продлить аренду парковочного места
////                let _ = print("false00 \(isArenda)")
//            }
            
            switch isStatusArenda{
            case true:
                setStatusRent(isArenda: isStatusArenda)
                let _ = print("true000 \(isStatusArenda)")
            case false:
                setStatusRent(isArenda: isStatusArenda)
                addData()
                // продлить аренду парковочного места
                let _ = print("false00 \(isStatusArenda)")
            }
        } label: {
            Capsule(style: .circular)
                .fill(color)
                .frame(width: size.width * 0.40, height: 40)
        }
    }*/
    
    private var rentextendText: some View{
        return VStack{
            if parkingViewModel.getStatusRent(idplace: id, context: viewContext){
                Text("Продлить")
            } else{
                Text("Арендовать")
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

struct GreenButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: size.width * 0.40, height: 40)
            .background(Color.green)
            .clipShape(Capsule(style: .circular))
            .foregroundColor(.white)
    }
}

struct RedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: size.width * 0.40, height: 40)
            .background(Color.red)
            .clipShape(Capsule(style: .circular))
            .foregroundColor(.white)
    }
}
