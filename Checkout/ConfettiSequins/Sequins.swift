//
//  Sequins.swift
//  Checkout
//
//  Created by Waseem Akram on 07/04/21.
//

import UIKit
import SwiftUI

class Sequins: Identifiable, Particle {

    
    var id = UUID()
    let color: ConfettiColor
    var yBoundary: CGFloat
    var position: Vector2D
    var terminalVelocity: CGFloat
    var timeElapsed: CGFloat = 0
    var velocity = Vector2D(x: 0, y: 0)
    
    private let gravity = Vector2D(x: 0, y: 0.5)

    init(position: Vector2D, initialVelocity: Vector2D, yBoundary: CGFloat, terminalVelocity: CGFloat, color: ConfettiColor) {
        self.position = position
        self.velocity = initialVelocity
        self.yBoundary = yBoundary
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
//        if(velocity.y > -4) {
//            velocity.y = min(velocity.y, terminalVelocity)
//        }
        position.add(vector: self.velocity)
        
    }
    
}
