//
//  LaunchScreenView.swift
//  AHE Simple Supply
//
//  Created by Will Gibson on 3/26/25.
//

import SwiftUI

/// Launch Screen View
///
///  Works in two phases:
///      The elements (text and image) grow from 20% to 105%
///      The elements return to 100% size
///      This creates an effect like a little pop
struct LaunchScreenView: View {
    
    
    /// Determine whether the app is active or not.
    @State private var isActive = false
    /// Determines if the animation is in the second phase
    @State private var secondPhase = false
    /// Determine size of elements.
    ///
    /// This begins at 20% or 0.2, goes up to 105% or 1.05 in phase one, and then ends at 100% or 1.0 in the second phase.
    @State private var size = 0.2
    /// Determine opacity of elements.
    ///
    /// Begins at 0.2, then goes up to 1.0 over the course of phase 1, remaining there for the rest of the animations.
    @State private var opacity = 0.2
    
    var body: some View {
        // isActive becomes true once the launch animation is done.
        if isActive {
            MainView()
            
        // Note: The code is written backwards on this page. firstPhase runs first, the secondPhase runs
        } else {
            if secondPhase {
                // most of this code is simply creating the logo using SF Symbols. All colors are defined in Assets.xcassets file.
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
                // The animation takes only .2 seconds to complete, this async waits an extra second holding on the launch screen before the main screen opens.
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        self.secondPhase = false
                        self.isActive = true
                    }
                }
            } else {
                // This is firstPhase. Again, almost all of the code is simply creating the logo with SF Symbols
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
                    // This portion takes the full 1.2 seconds, and the dispatch queue below waits until it finishes to start the secondPhase.
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
