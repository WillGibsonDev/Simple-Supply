//
//  SimpleSupplyApp.swift
//  Simple Supply
//
//  Created by Will Gibson on 9/4/24.
//

import SwiftUI
import SwiftData

@main
struct AHE_Inventory_AppApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchScreenView()
                .modelContainer(for: [Material.self, Product.self, ProductMaterial.self])
        }
    }
}
