//
//  ConfettiSequinDriver.swift
//  ConfettiButton
//
//  Created by Waseem Akram on 28/03/21.
//


import SwiftUI


class ConfettiSequinDriver: ObservableObject {
    
    @Published var confetties = [Confetti]()
    
    
    var confettiCount = 40
    var sequinCount = 40
    
    private var displayLink: CADisplayLink?
    private var systemSize: CGSize = .init(width: 1000, height: 1000)
    private var emitterFrame: CGRect = .zero
    
    init(){
        self.confetties = []
        self.displayLink = CADisplayLink(target: self, selector:  #selector(update))
        displayLink?.add(to: .current, forMode: .common)
//        displayLink?.preferredFramesPerSecond = 30
        displayLink?.isPaused = true
    }
    
    func setSystem(size: CGSize){
        systemSize = size
    }
    
    
    func setEmitterFrame(frame: CGRect) {
        self.emitterFrame = frame
    }
    
    func makeConfetti() -> Confetti {
        let velocityX = CGFloat.random(in: -0.5 ... 0.5)
        var velocityY: CGFloat = CGFloat.random(in: 12...16)
        if Int.random(in: 0...100) < 20 {
            velocityY *= 1.2
        }
        return Confetti(
            size: CGSize(width: CGFloat.random(in: 6 ... 12), height: CGFloat.random(in: 15...30)),
            position: Vector2D(cgPoint: CGPoint(x: CGFloat.random(in: emitterFrame.minX ... emitterFrame.maxX), y: emitterFrame.minY)),
            initialVelocity: Vector2D(
                x: velocityX,
                y: -velocityY
            ),
            yBoundary: systemSize.height + 50,
            rotation: Double.random(in: 0 ..< 360),
            terminalVelocity: 4,
            color: confettiColors[Int.random(in: 0..<confettiColors.count)]
        )
    }
    
    
   
    
    func blowConfetti() {
        //start displaylink
        for _ in 0 ..< confettiCount {
            let confetti = makeConfetti()
            confetties.append(
                confetti
            )
        }
        displayLink?.isPaused = false
    }
    
    
    @objc func update(displayLink: CADisplayLink){
        confetties.forEach { $0.update() }
        confetties = confetties.filter { !$0.isOutOfBoundary() }
        //pause the update when all confetties are out of the screen, to prevent the performance.
        if confetties.count == 0 {
            displayLink.isPaused = true
        }
        self.objectWillChange.send()
    }
    
    deinit {
        displayLink?.invalidate()
    }
    
}
