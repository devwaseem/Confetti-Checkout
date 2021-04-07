//
//  SequinView.swift
//  Checkout
//
//  Created by Waseem Akram on 08/04/21.
//

import SwiftUI

struct SequinView: View {
    
    var x: CGFloat
    var y: CGFloat
    var color: Color
    
    var body: some View {
        VStack(spacing: 0){
            Circle()
                .fill(color)
        }
        .frame(width: 5, height: 5)
        .position(x: x, y: y)
        .animation(.linear)
    }
    
}
