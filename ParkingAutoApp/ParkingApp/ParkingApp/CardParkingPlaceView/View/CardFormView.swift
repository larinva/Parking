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
    
    //Core Data
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: Parking.fetchRequest0(.all)) private var parking: FetchedResults<Parking>
    
    var id: String
    
    var isStatusArenda: Bool = {
        let filter = parking.filter{ $0.idPlace == "1" }
        let result = filter.first?.isArenda == true
        return result
    }()
    
    @Environment(\.editMode) private var editMode
    
    private let imageSize: CGFloat = 22
   
    private let clientsCardText = "Карточка клиента"
    private let personImage = "person"

    var body: some View{
        Form{
            ProfileFotoView(idPlace: id, isStatus: isStatusArendaPlace() ? true : false)
            InfoClientSectionView()
            //DatePickerView(model: cardDetailViewModel)
        }
    }
    
    func isStatusArendaPlace() -> Bool {
        let filter = parking.filter{ $0.idPlace == id }
        return filter.first?.isArenda == true
    }
}


extension CardFormView{
    @ViewBuilder
    private func InfoClientSectionView()-> some View{
        Section(header: Text(clientsCardText)){
            
            editFormView()
            
            if isStatusArendaPlace() == true && editMode?.wrappedValue.isEditing == false{
                let _ = print("yes")
                downFormView()
                
            }else{
                editFormView()
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
            TextField("", text: $cardDetailViewModel.data.ovnerAuto)
            TextField("", text: $cardDetailViewModel.data.numberFone)
            TextField("", text: $cardDetailViewModel.data.carBrand)
            TextField("", text: $cardDetailViewModel.data.numberAuto)
        }
    }
}
