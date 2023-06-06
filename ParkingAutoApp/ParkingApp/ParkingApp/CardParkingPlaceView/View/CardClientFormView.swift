//
//  CardFormView.swift
//  ParkingApp
//
//  Created by Вячеслав Ларин on 26.05.2023.
//

import SwiftUI

struct CardClientFormView: View {
    //MARK: ViewModel
    @StateObject var cardDetailViewModel: CardParkingPlaceViewModel
    
    @Environment(\.editMode) private var editMode
    
    //Core Data
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: Parking.fetchRequest0(.all)) private var parking: FetchedResults<Parking>
    
    var id: String

    var isStatusArenda: Bool {
        get{
            let filter = parking.filter{ $0.idPlace == id }
            let result = filter.first?.isArenda == true
            return result
        }
    }

    private let clientsCardText = "Карточка клиента"
    private let personImage = "person"

    var body: some View{
        Form{
            ProfileFotoView(idPlace: id, isStatus: isStatusArenda ? true : false)
            InfoClientSectionView()
            DatePickerView(model: cardDetailViewModel)
        }
    }
}


extension CardClientFormView{
    @ViewBuilder
    private func InfoClientSectionView()-> some View{
        Section(header: Text(clientsCardText)){

            if isStatusArenda == false || editMode?.wrappedValue.isEditing == true{
                let _ = print("editform")
                editFormView()
            }else{
                let _ = print("downform")
                downFormView()
            }
        }
        .onAppear{
            cardDetailViewModel.loadCoreData(id: id, context: viewContext)
            
            /*cardDetailViewModel.loadArendaPlace(
                idplace: id,
                place: parking
            )*/
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
            TextField(PersonData.ovnerAuto, text: $cardDetailViewModel.data.ovnerAuto)
        }
        
        HStack{
            Image(systemName: "phone.circle")
                .resizable()
                .imageStyle()
            TextField(PersonData.numberFone, text: cardDetailViewModel.maskPhoneBinding())
                .keyboardType(.numberPad)
                .onAppear{
                    cardDetailViewModel.loadNumberFone()
                }
        }
        
        HStack{
            Image(systemName: "car")
                .resizable()
                .imageStyle()
            TextField(PersonData.carBrand, text: $cardDetailViewModel.data.carBrand)
        }
        
        HStack{
            Image(systemName: "person.fill")
                .resizable()
                .imageStyle()
            TextField(PersonData.numberAuto, text: $cardDetailViewModel.data.numberAuto)
        }
        }
    }
    
    private func downFormView()-> some View{
        return Section{
                Text(cardDetailViewModel.data.ovnerAuto)
                Text(cardDetailViewModel.data.numberFone)
                Text(cardDetailViewModel.data.carBrand)
                Text(cardDetailViewModel.data.numberAuto)
        }
    }
}
