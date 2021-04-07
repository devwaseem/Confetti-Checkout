//
//  ContentView.swift
//  Checkout
//
//  Created by Waseem Akram on 06/04/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var checkoutViewModel: CheckoutViewModel
    @ObservedObject var confettiSequinDriver: ConfettiSequinDriver
    
    var body: some View {
        GeometryReader { parentGeometry in
            ZStack {
                VStack(alignment: .leading) {
                    Text("Order")
                        .font(.custom("Gilroy", size: 50))
                        .fontWeight(.semibold)
                        .padding(.top, 50)
                    AddressView()
                        .frame(height: 120)
                        .padding(.horizontal, 8)
                    CartProductsView()
                        .frame(height: 120)
                    Spacer()
                    Divider()
                        .padding(.vertical, 24)
                    Spacer()
                    PriceView()
                    Spacer()
                    Spacer()
                }
                .padding(.horizontal, 24)
                .blur(radius: checkoutViewModel.isOrdering ? 12 : 0)
                .animation(.easeIn)
                
                VStack {
                    Spacer()
                    Text(checkoutViewModel.isOrderingDone ? "Order placed" : "Placing order")
                        .font(.custom("Gilroy", size: 50))
                        .fontWeight(.semibold)
                        .offset(x: checkoutViewModel.isOrdering ? 0 : -parentGeometry.size.width )
                        .animation(.easeOut)
                    Text(checkoutViewModel.isOrderingDone ? "Delivering in 30 minutes" : "This might take few minutes...")
                        .font(.custom("Gilroy", size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.black.opacity(0.7))
                        .padding(.vertical, 12)
                        .offset(x: checkoutViewModel.isOrdering ? 0 : -parentGeometry.size.width )
                        .animation(Animation.easeOut.delay(0.3))
                    Spacer()
                    Spacer()
                }
                
                ZStack {
                    HStack {
                        VStack {
                            if !checkoutViewModel.isOrdering {
                                Spacer()
                            }
                            Button(action: {
                                checkoutViewModel.order()
                            }, label: {
                                GeometryReader { buttonGeometry in
                                    ZStack {
                                        LoadingView(color: Color.white, width: 10, height: 10)
                                            .offset(y: checkoutViewModel.isOrdering && !checkoutViewModel.isOrderingDone ? 0 : -buttonGeometry.size.height)
                                        Text(checkoutViewModel.isOrderingDone ? "Success" : "Order" )
                                            .foregroundColor(Color.white)
                                            .frame(width: buttonGeometry.size.width, height: buttonGeometry.size.height)
                                            .offset(y: checkoutViewModel.isOrdering && !checkoutViewModel.isOrderingDone ? buttonGeometry.size.height : 0)
                                    }
                                    .clipped()
                                    .onChange(of: [checkoutViewModel.isOrdering], perform: { value in
                                        let frame = buttonGeometry.frame(in: .global)
                                        confettiSequinDriver.setEmitterFrame(frame: frame)
                                    })
                                }
                            })
                            .frame(width: getButtonWidth(parentViewWidth: parentGeometry.size.width), height: checkoutViewModel.isOrdering ? 75 : 50)
                            .background(Color.black)
                            .cornerRadius(checkoutViewModel.isOrdering ? 1000 : 10)
                            .animation(checkoutViewModel.isOrderingDone ? .spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0) : .spring())
                        }
                    }
                }
                
                ConfettiesBackgroundView(confettiSequinDriver: confettiSequinDriver)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .onAppear {
                confettiSequinDriver.setSystem(size: parentGeometry.size)
                checkoutViewModel.confettiSequinDriver = confettiSequinDriver
            }
        }
        
    }
    
    
    func getButtonWidth(parentViewWidth: CGFloat) -> CGFloat {
        if checkoutViewModel.isOrdering  {
            if checkoutViewModel.isOrderingDone {
                return 170
            }
            return 140
        }else {
            return parentViewWidth * 0.8
        }
    }
    
    
    
}


fileprivate struct AddressView: View {
    
    var body: some View {
        ZStack {
            Color("deluge")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .cornerRadius(20)
                .rotation3DEffect(
                    Angle.degrees(-3),
                    axis: (x: 0.0, y: 1.0, z: 0.5),
                    anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,
                    anchorZ: 0.0,
                    perspective: 2.0
                )
                .offset(x: -10)
                
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("20-30m")
                        .font(.custom("Gilroy", size: 17))
                        .foregroundColor(Color.white)
                        .fontWeight(.semibold)
                    Text("Lazyman Ave")
                        .foregroundColor(Color.white.opacity(0.7))
                        .fontWeight(.semibold)
                }
                Spacer()
                Button(action: {}, label: {
                    Text("Edit")
                        .font(.custom("Gilroy", size: 17))
                        .foregroundColor(Color("perfume"))
                        .bold()
                })
            }
            .padding(24)
        }
    }
}


fileprivate struct CartProductsView: View {
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Unhealthy food")
                        .font(.custom("Gilroy", size: 17))
                        .fontWeight(.semibold)
                    Text("x1")
                        .font(.custom("Gilroy", size: 14))
                        .foregroundColor(Color.gray)
                        .fontWeight(.medium)
                }
                Text("w/ depression")
                    .foregroundColor(Color.black.opacity(0.25))
                    .fontWeight(.semibold)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 8){
                Text("$95.00")
                    .font(.custom("Gilroy", size: 17))
                    .fontWeight(.semibold)
                Button(action: {}, label: {
                    Text("Edit")
                        .font(.custom("Gilroy", size: 17))
                        .underline()
                        .foregroundColor(Color("deluge"))
                        .fontWeight(.semibold)
                })
            }
        }
        .padding(24)
    }
    
}

fileprivate struct PriceView: View {
    
    var body: some View {
        VStack {
            HStack {
                Text("Subtotal")
                    .font(.custom("Gilroy", size: 17))
                    .foregroundColor(Color.black.opacity(0.25))
                    .fontWeight(.semibold)
                Spacer()
                Text("$95.00")
                    .font(.custom("Gilroy", size: 17))
                    .fontWeight(.semibold)
            }
            
            HStack {
                Text("Delivery charge")
                    .font(.custom("Gilroy", size: 17))
                    .foregroundColor(Color.black.opacity(0.25))
                    .fontWeight(.semibold)
                Spacer()
                Text("$5.00")
                    .font(.custom("Gilroy", size: 17))
                    .fontWeight(.semibold)
            }
            .padding(.top, 12)
            
            HStack {
                Text("Total")
                    .font(.custom("Gilroy", size: 30))
                    .fontWeight(.semibold)
                Spacer()
                Text("$100.00")
                    .font(.custom("Gilroy", size: 36))
                    
                    .fontWeight(.semibold)
            }
            .padding(.top, 24)
        }
        .padding(.horizontal,24)
    }
    
}

struct ConfettiesBackgroundView: View {
    
    @StateObject var confettiSequinDriver: ConfettiSequinDriver
    
    var body: some View {
        ZStack {
            ForEach(confettiSequinDriver.confetties) { confetti in
                ConfettiView(
                    x: confetti.position.x,
                    y: confetti.position.y,
                    yScale: confetti.yScale,
                    rotation: confetti.rotation,
                    size: confetti.size,
                    color: confetti.currentColor
                )
            }
            ForEach(confettiSequinDriver.sequins) { sequin in
                SequinView(
                    x: sequin.position.x,
                    y: sequin.position.y,
                    color: Color("darkblue-back")
                )
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(checkoutViewModel: CheckoutViewModel(), confettiSequinDriver: ConfettiSequinDriver())
    }
}
