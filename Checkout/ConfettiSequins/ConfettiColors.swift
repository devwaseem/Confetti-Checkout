//
//  ConfettiColors.swift
//  ConfettiButton
//
//  Created by Waseem Akram on 28/03/21.
//

import SwiftUI

struct ConfettiColor {
    let front: Color
    let back: Color
    
    init(name: String) {
        front = Color("\(name)-front")
        back = Color("\(name)-back")
    }
}

let confettiColors = [
    ConfettiColor(name: "purple"),
    ConfettiColor(name: "lightblue"),
    ConfettiColor(name: "darkblue"),
]
