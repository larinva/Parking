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
               /* DatePickerView(
                    viewModel: parkingViewModel)*/

            }
        ArendaPlaceView()
    }
}

extension CardParkingPlaceView{
    @ViewBuilder
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
                                parkingViewModel.updateCoreData(
                                            idplace: id,
                                            isArenda: isStatusArenda,
                                            context: viewContext
                                        )
                            }
                        }
                    }
                }
                .padding([.leading, .trailing, .top], 16)
            }
        }
    }
    
    @ViewBuilder
    private func ArendaPlaceView()-> some View{
        HStack{
            Button{
            } label: {
                parkingCancelAlert
            }.buttonStyle(RedButtonStyle())

            Button{
                parkingViewModel.updateCoreData(idplace: id, isArenda: true, context: viewContext)
            } label: {
                rentextendText
            }.buttonStyle(GreenButtonStyle())
        }
        .padding()
        .buttonStyle(.automatic)
    }

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
                    parkingViewModel.updateCoreData(
                        idplace: id,
                        isArenda: false,
                        context: viewContext)
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
