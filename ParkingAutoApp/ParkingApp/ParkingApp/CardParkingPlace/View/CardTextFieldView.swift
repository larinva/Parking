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
    var text: Binding<String>
    
    var body: some View{
        HStack{
            Image(systemName: image)
                .resizable()
                .imageStyle()
            TextField(data, text: text)
        }
    }
}
