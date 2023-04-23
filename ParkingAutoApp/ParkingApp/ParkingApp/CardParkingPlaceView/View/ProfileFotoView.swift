//
//  ProfileFotoView.swift
//  ParkingApp
//
//  Created by vacheslavBook on 02.02.2023.
//

import SwiftUI

struct ProfileFotoView: View {
    var title: String
    var status: Bool
    
    var body: some View {
        
        HStack(spacing: 16){
            Circle()
                .fill(.gray).opacity(0.5)
                .frame(width: 100, height: 100, alignment: .center)
                .overlay {
                    Text("Фото")
                        .foregroundColor(.white)
                        .font(.title2)
                        .bold()
                }
            
            VStack(alignment: .leading, spacing: 8){
                Text("\(String(describing: status ? "в аренде" : " свободен"))")
                    .foregroundColor(status ? .red : .green)
                    .font(.caption)
                    .bold()
                
                Text("Парковочное место \(title)")
                    .font(.title3)
                    .bold()
            }
        }
        .padding()
    }
}

struct ProfileFotoView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileFotoView(title: "Title", status: true)
    }
}