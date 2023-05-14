//
//  ScaleModified.swift
//  ParkingApp
//
//  Created by vacheslavBook on 13.05.2023.
//

import SwiftUI

struct ScaleModified: ViewModifier {
    @State private var currentScale: CGFloat = 0
    @State private var finalScale: CGFloat = 1
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(finalScale + currentScale)
            .gesture(
                MagnificationGesture()
                    .onChanged{ newScale in
                        currentScale = newScale
                    }
                    .onEnded({ scale in
                        finalScale = scale
                        currentScale = 0
                    })
            )
    }
}

extension View{
    func pinchZoom() -> some View {
        modifier(ScaleModified())
    }
}
