//
//  ParserSVG.swift
//  ParkingApp
//
//  Created by vacheslavBook on 19.01.2023.
//

import SwiftUI
import SVGView

class ParserSVGViewModel: NSObject, ObservableObject {
    @Published var nodeDict: [NodeId] = [NodeId]()
    @Published var isDragging = false
    
    var nodeTag = ""
    var view: SVGView!
    
    private let url = Bundle.main.url(forResource: "MapParkengin",
                                      withExtension: "svg")
    
    override init() {
        super.init()
        parse()
    }
}

extension ParserSVGViewModel: XMLParserDelegate{
    private func parse(){
        if let url = url {
            let parserXML = XMLParser(contentsOf: url)
            parserXML?.delegate = self
            parserXML?.parse()
        }
    }
    
    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]
    ){
        if (elementName == "rect") {
            nodeDict.append(NodeId(ids: attributeDict["id"] ?? "",
                                   title: attributeDict["title"] ?? ""))
        }
    }
}
