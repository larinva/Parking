//
//  PaymentDetailView.swift
//  ParkingApp
//
//  Created by vacheslavBook on 25.03.2023.
//

import SwiftUI

struct PaymentView: View {
    
    //MARK:
    @State private var isPicker: Bool = false
    
    //MARK: Payment
    @State private var price: String = "0"
    @State private var price0: String = "0"
    
    var body: some View {
        Section(header: Text("Оплата")){
            Text("\(price)")
            Text("\(price0)")
            
            Toggle(isOn: $isPicker){
                Text("Оплата за месяц")
            }
            .onChange(of: isPicker) { newValue in
                if isPicker{
                    priceMonth()
                } else{
                    price = "0"
                }
            }
        }
    }
    
    func paymentMonth() -> Date {
        let calendar = Calendar.current
        let dateComponent = calendar.dateComponents([.day], from: .now)
        let nextDate = calendar.nextDate(after: .now, matching: dateComponent, matchingPolicy: .strict)
        return nextDate ?? Date.now
    }
    
    func priceMonth(){
        let date = paymentMonth()
        print(date)
        price = "3000"
    }
    
    func generateDate(dateStart: Date, dateEnd: Date) -> () {
        let calendar = Calendar.current
        var dateComponent = calendar.dateComponents([.day], from: dateStart, to: dateEnd)
        dateComponent.timeZone = .current

        let monyDay = dateComponent.day ?? 0
        price0 = String(monyDay * 100)
        print(price0)
    }
    
    func tttttt() -> () {
        price = "10000000"
        print(price)
    }
}
