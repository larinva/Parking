//
//  LoadPlaces.swift
//  ParkingApp
//
//  Created by vacheslavBook on 09.02.2023.
//

import CoreData


final class LoadPlaces: NSObject{
    private let url = Bundle.main.url(forResource: "MapParkengin",
                                      withExtension: "svg")
 
    private var context: NSManagedObjectContext{
        PersistenceController.shared.container.viewContext
    }
    
    private var nodeDict: [NodeId] = [NodeId]()
    
    func load() -> () {
        parse()
    }
}

extension LoadPlaces: XMLParserDelegate{
    
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
        
        if elementName == "rect" {
                let node = NodeId(ids: attributeDict["id"] ?? "",
                                  title: attributeDict["title"] ?? "")
                Places.update(from: node, in: context)
        }
    }
}
