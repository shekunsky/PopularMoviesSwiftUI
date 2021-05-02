//
//  ActivityIndicator.swift
//  PopularMoviesSwiftUI
//
//  Created by Alex2 on 18.08.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import SwiftUI
import Foundation

struct ActivityIndicator: View {
    
    @State private var isAnimating: Bool = false
    
    var body: some View {
        GeometryReader { (geometry: GeometryProxy) in
            let size = CGSize(width: geometry.size.width / 5, height: geometry.size.height / 5)
            let offset = geometry.size.width / 10 - geometry.size.height / 2
            let rotationEffect: Angle = !isAnimating ? .degrees(0) : .degrees(360)
            ForEach(0..<5) { index in
                let scaleEffect = !isAnimating ? 1 - CGFloat(index) / 5 : 0.2 + CGFloat(index) / 5
                Group {
                    Circle()
                        .frame(width: size.width, height: size.height)
                        .scaleEffect(scaleEffect)
                        .offset(y: offset)
                }.frame(width: geometry.size.width, height: geometry.size.height)
                .rotationEffect(rotationEffect)
                .animation(
                    Animation
                        .timingCurve(0.5, 0.15 + Double(index) / 5, 0.25, 1, duration: 1.5)
                        .repeatForever(autoreverses: false)
                )
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear {
            isAnimating = true
        }
    }
}

struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicator()
    }
}
