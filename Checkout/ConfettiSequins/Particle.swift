//
//  Particle.swift
//  Checkout
//
//  Created by Waseem Akram on 07/04/21.
//

import Foundation

protocol Particle {
    func update()
    func isOutOfBoundary() -> Bool
}
