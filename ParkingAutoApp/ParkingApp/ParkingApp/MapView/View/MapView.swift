//
//  MapSVG.swift
//  ParkingApp
//
//  Created by vacheslavBook on 21.01.2023.
//

import SwiftUI
import SVGView


struct MapView: View {

    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(fetchRequest: Places.fetchRequest1()) var places: FetchedResults<Places>
    
    @ObservedObject var parserMapViewModel = ParserSVGViewModel()

    @State var isDragging = false
    @State var isAlert: Bool = false
    
    var view: SVGView!
   
    init(){
        loadMapView()
    }

    var body: some View {
        NavigationStack{
            ScrollView(.horizontal){
                ZStack{
                    Image("sample.png")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                    SVGViewMap()
                        .overlay {
//                            textNode()
                        }
                        .onAppear{
                            selectedNode()
                        }
                }
            } .navigationTitle("Карта парковки")
        }
    }
}

