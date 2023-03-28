//
//  PaymentDetailView.swift
//  ParkingApp
//
//  Created by vacheslavBook on 25.03.2023.
//

import SwiftUI

struct PaymentDetailView: View {
    
    //MARK:
    @State private var isPicker: Bool = false
    
    //MARK: Payment
    var price: String = ""
    
    var body: some View {
        Section(header: Text("Оплата")){
            Text("\(price)")
            
            if isPicker{
                Text("\(price)")
            }
            Toggle(isOn: $isPicker){
                Text("Оплата за месяц")
                
            }
        }
    }
}
