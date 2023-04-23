//
//  NumberPhoneMaskView.swift
//  ParkingApp
//
//  Created by vacheslavBook on 23.04.2023.
//

import SwiftUI

struct NumberPhoneMaskView: View {
    let maskPhone = "+X-XXX-XXX-XX-XX"
    @State private var text = ""
    
    var body: some View {
        VStack{
            let textChangeBinding = Binding<String>(
                get: {
                    FilterNumberPhone.format(with: maskPhone, phone: text)
                },
                set: {
                    text = $0
                }
            )
            TextFieldContainer(placeholder: "+7", text: textChangeBinding)
        }.padding()
    }
}

struct NumberPhoneMaskView_Previews: PreviewProvider {
    static var previews: some View {
        NumberPhoneMaskView()
    }
}
