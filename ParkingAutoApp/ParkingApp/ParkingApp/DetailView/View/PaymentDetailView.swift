//
//  PaymentDetailView.swift
//  ParkingApp
//
//  Created by vacheslavBook on 25.03.2023.
//

import SwiftUI

struct PaymentDetailView: View {
    
    //MARK:
    @State private var picker: Bool = false
    
    //MARK: Payment
    var price: String = "100"
    
    var body: some View {
        Section(header: Text("Оплата")){
            Text("\(price)")
            Toggle(isOn: $picker){
                let _ = print("picker")
            }
        }
    }
}
