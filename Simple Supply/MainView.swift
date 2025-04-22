//
//  SwiftUIView.swift
//  Simple Supply
//
//  Created by Will Gibson on 11/21/24.
//

import SwiftUI
import SwiftData

/// Main View of the app.
///
/// A tab view which defaults to the products page.
///
/// See also ``MaterialsView``
///
/// See also ``ProductsView``
struct MainView: View {
    
    // Default Model Context
    @Environment(\.modelContext) private var context
    
    // List of all materials stored in the context
    @Query var materials: [Material]

    var body: some View {
        TabView {
            Tab("Products", systemImage: "tray.fill") {
                ProductsView()
            }
            Tab("Materials", systemImage: "tray.fill") {
                MaterialsView()
            }
        }
        .tabViewStyle(.sidebarAdaptable)
        
    }
}



#Preview {
    MainView()
}


