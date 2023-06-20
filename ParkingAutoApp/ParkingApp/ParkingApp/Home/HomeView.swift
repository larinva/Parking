//
//  HomeView.swift
//  ParkingApp
//
//  Created by vacheslavBook on 06.02.2023.
//

import SwiftUI
import CoreData

struct HomeView: View {
    var body: some View {

        TabView{
            MapView()
                .tabItem {
                    Label("Карта", systemImage: "map")
                }
            AutoView()
                .tabItem {
                    Label("Авто", systemImage: "car")
                }
            NoficationView()
                .tabItem {
                    Label("Уведомления", systemImage: "ellipsis.circle.fill")
//                    Label("Настройки", systemImage: "ellipsis.circle.fill")
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
