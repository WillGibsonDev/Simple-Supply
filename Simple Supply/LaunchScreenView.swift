//
//  LaunchScreenView.swift
//  AHE Simple Supply
//
//  Created by Will Gibson on 3/26/25.
//

import SwiftUI

struct LaunchScreenView: View {
    
    @State private var isActive = false
    @State private var secondPhase = false
    @State private var size = 0.2
    @State private var opacity = 0.2
    
    var body: some View {
        if isActive {
            MainView()
        } else {
            if secondPhase {
                VStack {
                    VStack {
                        Image(systemName: "shippingbox.and.arrow.backward.fill")
                            .font(.system(size: 150))
                            .foregroundStyle(Color("SupplyColor01"), Color("SupplyColor03"), Color("SupplyColor03"))
                        Text("Simple Supply")
                            .font(Font.custom("Baskerville-bold", size: 46))
                            .foregroundStyle(Color("SupplyColor02").opacity(0.8))
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeOut(duration: 0.2)) {
                            self.size = 1.0
                            self.opacity = 1.0
                        }
                        
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        self.secondPhase = false
                        self.isActive = true
                    }
                }
            } else {
                VStack {
                    VStack {
                        Image(systemName: "shippingbox.and.arrow.backward.fill")
                            .font(.system(size: 150))
                            .foregroundStyle(Color("SupplyColor01"), Color("SupplyColor03"), Color("SupplyColor03"))
                        Text("Simple Supply")
                            .font(Font.custom("Baskerville-bold", size: 46))
                            .foregroundStyle(Color("SupplyColor02").opacity(0.8))
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.size = 1.05
                            self.opacity = 1.0
                        }
                        
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        self.secondPhase = true
                    }
                }
            }
        }
    }
}

#Preview {
    
    LaunchScreenView()
}
