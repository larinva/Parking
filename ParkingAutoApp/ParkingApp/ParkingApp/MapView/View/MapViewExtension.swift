//
//  MapViewExtension.swift
//  ParkingApp
//
//  Created by Вячеслав Ларин on 15.02.2023.
//

import SwiftUI
import SVGView

extension MapView{
    func SVGViewMap() -> some View {
        setNode()
        return viewSheet()
    }
    
    private func viewSheet()->some View{
        return view.sheet(isPresented: $isDragging) {
            
            CardParkingPlaceView(
                idPlace: parserMapViewModel.nodeTag,
                isStatusArenda: isStatusArendaPlace() ? true : false
            )
        }
    }
}

extension MapView{
    mutating func loadMapView() -> () {
        let url = Bundle.main.url(forResource: "MapParkengin",
                                          withExtension: "svg")
        if let url = url {
            view = SVGView(contentsOf: url)
        }
    }
}

extension MapView{
    
    func isStatusArendaPlace() -> Bool {
        let filter = places.filter{ $0.idPlace == parserMapViewModel.nodeTag }
       
        return filter.first?.isArenda == true
    }
    
    func selectedNode() {
        if places.isEmpty{
            print("base no")
        } else {
            let filter = places.filter{$0.isArenda}
            selectedNodesColor(nodeTag: filter.map{ $0.idPlace})
        }
    }
    
    private func setNode() -> () {
        for node in parserMapViewModel.nodeDict{
            onTapNode(nodeTag: node.ids ?? "")
        }
    }


    private func onTapNode(nodeTag: String){
        view.getNode(byId: nodeTag)?.onTapGesture {
            
            self.isDragging = true
            
            withAnimation {
                self.selectedNodeColor(nodeTag: nodeTag)
            }
        }
    }
    
    private func selectedNodeColor(nodeTag : String) {
        if let shape = view.getNode(byId: nodeTag) as? SVGShape {
            shape.fill = SVGColor(r: 223, g: 35, b: 35, opacity: 1)
            parserMapViewModel.nodeTag = nodeTag
        }
    }
    
    private func selectedNodesColor(nodeTag : [String]) {
        for tag in nodeTag{
            if let shape = view.getNode(byId: tag) as? SVGShape {
                shape.fill = SVGColor(r: 223, g: 35, b: 35, opacity: 1)
            }
        }
    }
    
    /*private func textNode()-> some View{
        return ForEach (parse.nodeDict){id in
//            if let node = parse.view.getNode(byId: id.id){
//                Text("\(String(describing: node.id ?? ""))")
//                    .font(.caption2)
//                    .position(x: node.frame().midX, y: node.frame().midY)
//            }
        }
    }*/
}
