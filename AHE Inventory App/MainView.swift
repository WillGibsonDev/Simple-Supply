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
//    @State private var materials: [Material] = []
    @Query var materials: [Material]

    var body: some View {
        TabView {
            ProductsView()
            MaterialsView()
        }
        .tabViewStyle(.sidebarAdaptable)
        
    }
}



#Preview {
    MainView()
}


