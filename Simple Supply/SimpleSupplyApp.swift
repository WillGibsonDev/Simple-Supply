//
//  AHE_Inventory_AppApp.swift
//  AHE Inventory App
//
//  Created by Will Gibson on 9/4/24.
//

import SwiftUI
import SwiftData

@main
struct AHE_Inventory_AppApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .modelContainer(for: [Material.self, Product.self, ProductMaterial.self])
        }
    }
}
