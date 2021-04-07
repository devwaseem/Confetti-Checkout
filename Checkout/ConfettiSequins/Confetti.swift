//
//  Confetti.swift
//  ConfettiButton
//
//  Created by Waseem Akram on 28/03/21.
//

import UIKit
import SwiftUI

class Confetti: Identifiable {
        
    var id = UUID()
    let color: ConfettiColor
    var size: CGSize
    var yBoundary: CGFloat
    var rotation: Double
    var position: Vector2D
    var terminalVelocity: CGFloat
    var yScale: CGFloat = 1
    var timeElapsed: CGFloat = 0
    var velocity = Vector2D(x: 0, y: 0)
    
    var currentColor: Color {
        yScale > 0.5 ? color.back : color.front
    }
    
    private let gravity = Vector2D(x: 0, y: 0.5)

    init(size: CGSize, position: Vector2D, initialVelocity: Vector2D, yBoundary: CGFloat, rotation: Double, terminalVelocity: CGFloat, color: ConfettiColor) {
        self.size = size
        self.position = position
        self.velocity = initialVelocity
        self.yBoundary = yBoundary
        self.rotation = rotation
        self.terminalVelocity = terminalVelocity
        self.color = color
    }
    

    func isOutOfBoundary() -> Bool {
        return position.y > yBoundary + 50
    }
    
    func update() {
        
        let force = Vector2D.zero()
        force.add(vector: gravity)
        
        let randomWind = CGFloat.random(in: 0 ..< 0.2)
        let randomHorizontalWind = Vector2D(x: CGFloat.random(in: 0 ..< 1) > 0.5 ? randomWind : -randomWind, y: 0)
        force.add(vector: randomHorizontalWind)
        velocity.add(vector: force)
        if(velocity.y > -4) {
            velocity.y = min(velocity.y, terminalVelocity)
            yScale = map(cos(timeElapsed), -1.0, 1.0, 0, 1.0)
            timeElapsed += 0.25
        }
        
        position.add(vector: self.velocity)
        
    }
    
}
