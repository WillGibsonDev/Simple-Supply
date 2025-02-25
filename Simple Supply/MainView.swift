//
//  SwiftUIView.swift
//  AHE Inventory App
//
//  Created by Will Gibson on 11/21/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) private var context
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


