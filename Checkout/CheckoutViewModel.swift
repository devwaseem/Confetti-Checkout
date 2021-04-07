//
//  CheckoutViewModel.swift
//  Checkout
//
//  Created by Waseem Akram on 07/04/21.
//

import Foundation

class CheckoutViewModel: ObservableObject {
    
    var confettiSequinDriver: ConfettiSequinDriver!
    
    @Published var isOrdering = false
    @Published var isOrderingDone = false
    
    func order() {
        isOrdering = true
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
            self.isOrderingDone = true
            self.confettiSequinDriver.blowConfetti()
        }
    }
    
}
