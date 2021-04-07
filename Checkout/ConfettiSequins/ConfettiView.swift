//
//  ConfettiView.swift
//  ConfettiButton
//
//  Created by Waseem Akram on 28/03/21.
//

import SwiftUI

struct ConfettiView: View {
    
    var x: CGFloat
    var y: CGFloat
    var yScale: CGFloat
    var rotation: Double
    var size: CGSize
    var color: Color
    
    var body: some View {
        VStack(spacing: 0){
            Rectangle()
                .fill(color)
        }
        .scaleEffect(y: yScale)
        .rotationEffect(Angle.degrees(rotation))
        .frame(width: size.width, height: size.height)
        .position(x: x, y: y)
        .animation(.linear)
    }
    
}
