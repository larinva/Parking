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
    
    @State var text = ""
    

    
    var body: some View{
        var _text = Binding<String> (
            get: {
                self.text.lowercased()
        },
            set: {
                self.text = $0
        }
    )
        HStack{
            Image(systemName: image)
                .resizable()
                .imageStyle()
            TextField(data, text: _text)
        }
    }
}
