//
//  CardTextFieldView.swift
//  ParkingApp
//
//  Created by vacheslavBook on 10.06.2023.
//

import SwiftUI

struct CardTextFieldView: View{
    var image: String
    var data: String
    @Binding var text: String
    
    var body: some View{
        HStack{
            Image(systemName: image)
                .resizable()
                .imageStyle()
            TextField(PersonData.ovnerAuto, text: $text)
        }
    }
}
