//
//  ProfileFotoView.swift
//  ParkingApp
//
//  Created by vacheslavBook on 02.02.2023.
//

import SwiftUI

struct ProfileFotoView: View {
    var idplace: String
    
    //var title: String
    var isStatus: Bool
    
    var body: some View {
        
        HStack(spacing: 20){
            Circle()
                .fill(.gray).opacity(0.5)
                .frame(width: 100, height: 100, alignment: .center)
                .overlay {
                    Text(PersonData.foto)
                        .foregroundColor(.white)
                        .font(.title2)
                        .bold()
                }
            
            VStack(alignment: .leading, spacing: 8){
                StatusArendaView(isStatus: isStatus)
                
                Text(PersonData.parkingPlace + " " + idplace)
                    .font(.title3)
                    .bold()
            }
        }
        .padding(8)
    }
}
