//
//  LoadingView.swift
//  Checkout
//
//  Created by Waseem Akram on 07/04/21.
//

import SwiftUI

struct LoadingView: View {
    
    var color: Color
    var width: CGFloat
    var height: CGFloat
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    private var circleSize: CGFloat = 0
    
    @State var stride: CGFloat = 0
    @State var circle1YOffset: CGFloat = 0
    @State var circle2YOffset: CGFloat = 0
    @State var circle3YOffset: CGFloat = 0
    @State var circle4YOffset: CGFloat = 0
    
    init(color: Color, width: CGFloat, height: CGFloat) {
        self.color = color
        self.width = width
        self.height = height
        self.circleSize = height * 0.5
    }
    
    var body: some View {
        HStack {
            Circle()
                .fill(color)
                .offset(y: circle1YOffset)
                .animation(.linear)
                .frame(width: circleSize, height: circleSize)
            Circle()
                .fill(color)
                .offset(y: circle2YOffset)
                .animation(.linear)
                .frame(width: circleSize, height: circleSize)
            Circle()
                .fill(color)
                .offset(y: circle3YOffset)
                .animation(.linear)
                .frame(width: circleSize, height: circleSize)
            Circle()
                .fill(color)
                .offset(y: circle4YOffset)
                .animation(.linear)
                .frame(width: circleSize, height: circleSize)
        }
        .frame(width: width, height: height, alignment: .center)
        .onReceive(timer, perform: { _ in
            stride += 100
            circle1YOffset = map(sin(stride), -1, 1, -height, height)
            circle2YOffset = map(sin(stride + 2), -1, 1, -height, height)
            circle3YOffset = map(sin(stride + 3), -1, 1, -height, height)
            circle4YOffset = map(sin(stride + 4), -1, 1, -height, height)
        })
        
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(color: Color.red, width: 50, height: 10)
    }
}
