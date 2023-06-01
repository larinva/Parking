//
//  CardFormView.swift
//  ParkingApp
//
//  Created by Вячеслав Ларин on 26.05.2023.
//

import SwiftUI


struct CardFormView: View {
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

    private let imageSize: CGFloat = 22
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


extension CardFormView{
    @ViewBuilder
    private func InfoClientSectionView()-> some View{
        Section(header: Text(clientsCardText)){

            if editMode?.wrappedValue.isEditing == true{
                let _ = print("editform")
                editFormView()
            }else{
                let _ = print("downform")
                downFormView()
            }
        }
        .onAppear{
            cardDetailViewModel.loadArendaPlace(
                idplace: id,
                place: parking
            )
        }
    }
}

extension CardFormView{
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
            List{
                Text(cardDetailViewModel.data.ovnerAuto)
                Text(cardDetailViewModel.data.numberFone)
                Text(cardDetailViewModel.data.carBrand)
                Text(cardDetailViewModel.data.numberAuto)
            }
        }
    }
}
