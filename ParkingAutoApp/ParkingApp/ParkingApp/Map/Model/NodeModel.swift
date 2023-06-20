//
//  NodeModel.swift
//  ParkingApp
//
//  Created by Вячеслав Ларин on 23.01.2023.
//

import Foundation

struct NodeId: Identifiable {
    var id = UUID()
    var ids: String?
//    var isArenda: Bool?
    var title:String
}
