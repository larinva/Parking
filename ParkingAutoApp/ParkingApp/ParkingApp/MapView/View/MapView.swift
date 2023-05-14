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
    @State private var currentScale: CGFloat = 0
    @State private var finalScale: CGFloat = 1
    
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
//                        .pinchZoom()
//                        .scaleEffect(finalScale + currentScale)
//                        .gesture(
//                            MagnificationGesture()
//                                .onChanged{ newScale in
//                                    currentScale = newScale
//                                }
//                                .onEnded({ scale in
//                                    finalScale = scale
//                                    currentScale = 0
//                                })
//                        )
                    
                    SVGViewMap()
//                        .pinchZoom()
//                        .overlay {
//                            textNode()
//                        .scaleEffect(finalScale + currentScale)
//                        .gesture(
//                            MagnificationGesture()
//                                .onChanged{ newScale in
//                                    currentScale = newScale
//                                }
//                                .onEnded({ scale in
//                                    finalScale = scale
//                                    currentScale = 0
//                                })
//                        )
//                        }
                        .onAppear{
                            selectedNode()
                        }
                }
            } .navigationTitle("Карта парковки")
        }
    }
}

