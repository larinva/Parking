//
//  MapSVG.swift
//  ParkingApp
//
//  Created by vacheslavBook on 21.01.2023.
//

import SwiftUI
import SVGView


struct MapView: View {
    @Environment(\.colorScheme) var scheme
    @Environment(\.managedObjectContext) var viewContext
    //@FetchRequest(fetchRequest: Places.fetchRequest1()) var places: FetchedResults<Places>
    @FetchRequest(fetchRequest: Parking.fetchRequest0(.all)) var parking: FetchedResults<Parking>
    @ObservedObject var svgid = ParserSVGViewModel()
    @StateObject var viewModel = ParkingViewModel()
    
    @State var isDragging = false

    var view: SVGView!
    
    init(){
        loadMapView()
    }
    
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading){
                Text("Карта парковки")
                    .font(.title)
                Text("Блинова, 23А")
                    .font(.subheadline)
            }
            .padding()
            
            NavigationStack{
                ScrollView(.horizontal){
                    ZStack{
                        Image(scheme == .dark ? "sampleDark.png" : "sample.png")
                            .resizable()
                            .aspectRatio(contentMode: .fill) 
                        
                        SVGViewMap()
                            .onAppear{
                                selectedNode()
                            }
                    }
                }
            }
        }
    }
}

