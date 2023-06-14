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
    private let phone = "phone.circle"
    private let car = "car"
    private let person = "person"
    
    var idplace: String
    var isStatus: Bool 
    
    //MARK: - ViewModel
    @StateObject var viewModel: ParkingViewModel
    
    @Environment(\.editMode) private var editMode
    
    //MARK: - Core Data
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View{
        InfoClientSectionView()
    }
}


extension CardClientFormView{
    @ViewBuilder
    private func InfoClientSectionView()-> some View{
        Section(header: Text(clientsCardText)){
            if isStatus == false || editMode?.wrappedValue.isEditing == true{
                editFormView()
            }else{
                downFormView()
            }
        }
        .onAppear{
             viewModel.loadCoreData(idplace: idplace,
                                           context: viewContext)
        }
    }
}


extension CardClientFormView{
    private func editFormView()-> some View{
        return Section{
            CardTextFieldView(image: personImage,
                              data: PersonData.ovnerAuto,
                              text: $viewModel.data.ovnerAuto)
            
            CardTextFieldView(image: phone,
                              data: PersonData.numberFone,
                              text: viewModel.maskPhoneBinding())
            
            CardTextFieldView(image: car,
                              data: PersonData.carBrand,
                              text: $viewModel.data.carBrand)
            
            CardTextFieldView(image: person,
                              data: PersonData.numberAuto,
                              text: $viewModel.data.numberAuto)
        }
    }
    
    private func downFormView()-> some View{
        return Section{
            Text(viewModel.data.ovnerAuto)
            Text(viewModel.data.numberFone)
            Text(viewModel.data.carBrand)
            Text(viewModel.data.numberAuto)
        }
    }
}
