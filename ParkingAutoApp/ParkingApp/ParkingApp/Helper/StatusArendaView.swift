//
//  MyViewModifier.swift
//  ParkingApp
//
//  Created by Вячеслав Ларин on 05.05.2023.
//

import SwiftUI

struct StatusArendaView: View {
    var isStatus: Bool
    
    var body: some View{
        Text("\(String(describing: isStatus ? "в аренде" : " свободен"))")
            .foregroundColor(isStatus ? .red : .green)
            .font(.caption)
            .bold()
    }
}
