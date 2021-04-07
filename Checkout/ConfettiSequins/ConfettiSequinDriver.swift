//
//  ConfettiSequinDriver.swift
//  ConfettiButton
//
//  Created by Waseem Akram on 28/03/21.
//


import SwiftUI


class ConfettiSequinDriver: ObservableObject {
    
    @Published var confetties = [Confetti]()
    @Published var sequins = [Sequins]()
    
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
    
    func makeSequins() -> Sequins {
        let velocityX = CGFloat.random(in: -1 ... 1)
        var velocityY: CGFloat = CGFloat.random(in: 10...15)
        if Int.random(in: 0...100) < 50 {
            velocityY *= 1.2
        }
        return Sequins(
            position: Vector2D(cgPoint: CGPoint(x: CGFloat.random(in: emitterFrame.minX ... emitterFrame.maxX), y: emitterFrame.minY)),
            initialVelocity: Vector2D(
                x: velocityX,
                y: -velocityY
            ),
            yBoundary: systemSize.height + 50,
            terminalVelocity: 10,
            color: confettiColors[Int.random(in: 0..<confettiColors.count)]
        )
    }
    
    
   
    
    func blowConfetti() {
        
        for _ in 0 ..< confettiCount {
            confetties.append(
                makeConfetti()
            )
        }
        
        for _ in 0 ..< sequinCount {
            sequins.append(
                makeSequins()
            )
        }

        //start displaylink
        displayLink?.isPaused = false
    }
        
    private func filterInsideBoundary(particle: Particle) -> Bool {
        return !particle.isOutOfBoundary()
    }
    
    @objc func update(displayLink: CADisplayLink){
        
        let particles: [[Particle]] = [confetties, sequins]
        particles.flatMap { $0 }.forEach { $0.update() }
        confetties = confetties.filter(filterInsideBoundary)
        sequins = sequins.filter(filterInsideBoundary)
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
