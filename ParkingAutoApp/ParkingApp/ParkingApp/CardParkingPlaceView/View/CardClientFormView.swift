//
//  CardFormView.swift
//  ParkingApp
//
//  Created by Вячеслав Ларин on 26.05.2023.
//

import SwiftUI

struct CardClientFormView: View {
    private let clientsCardText = "Карточка клиента"
    private let personImage = "person"

    //MARK: - ViewModel
    @StateObject var parkingViewModel: ParkingViewModel
    
    @Environment(\.editMode) private var editMode
    
    //MARK: - Core Data
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: Parking.fetchRequest0(.all)) private var parking: FetchedResults<Parking>
    
    var id: String

    var isStatusArenda: Bool {
        get{
            let result = parkingViewModel.getStatusRent(
                id: id,
                context: viewContext
            )
            return result
        }
    }

    var body: some View{
        InfoClientSectionView()
    }
}


extension CardClientFormView{
    @ViewBuilder
    private func InfoClientSectionView()-> some View{
        Section(header: Text(clientsCardText)){

            if isStatusArenda == false || editMode?.wrappedValue.isEditing == true{
                editFormView()
                let _ = print("editFormView()")
            }else{
                downFormView()
                let _ = print("downFormView()")
            }
        }
        .onAppear{
             parkingViewModel.loadCoreData(id: id, context: viewContext)
        }
    }
}

extension CardClientFormView{
    private func editFormView()-> some View{
        return Section{
            HStack{
                Image(systemName: personImage)
                    .resizable()
                    .imageStyle()
            TextField(PersonData.ovnerAuto, text: $parkingViewModel.data.ovnerAuto)
        }
        
        HStack{
            Image(systemName: "phone.circle")
                .resizable()
                .imageStyle()
            TextField(PersonData.numberFone, text: parkingViewModel.maskPhoneBinding())
                .keyboardType(.numberPad)
                .onAppear{
                    parkingViewModel.loadNumberFone()
                }
        }
        
        HStack{
            Image(systemName: "car")
                .resizable()
                .imageStyle()
            TextField(PersonData.carBrand, text: $parkingViewModel.data.carBrand)
        }
        
        HStack{
            Image(systemName: "person.fill")
                .resizable()
                .imageStyle()
            TextField(PersonData.numberAuto, text: $parkingViewModel.data.numberAuto)
        }
        }
    }
    
    private func downFormView()-> some View{
        return Section{
            Text(parkingViewModel.data.ovnerAuto)
            Text(parkingViewModel.data.numberFone)
            Text(parkingViewModel.data.carBrand)
            Text(parkingViewModel.data.numberAuto)
        }
    }
}
