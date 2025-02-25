//
//  Material.swift
//  AHE Inventory App
//
//  Created by Will Gibson on 10/14/24.
//

import SwiftData
import SwiftUI

// Define the Material class as a SwiftData model
@Model
class Material{
    @Attribute(.unique) var name: String // Unique attribute for identification
    var quantity: Int

    init(name: String, quantity: Int) {
        self.name = name
        self.quantity = quantity
    }

    // Method to deduct material
    func use(amount: Int) -> Bool {
        if amount <= quantity {
            quantity -= amount
            print("\(amount) \(name) used. Remaining: \(quantity)")
            return true
        } else {
            print("Not enough \(name). Requested: \(amount), Available: \(quantity)")
            return false
        }
    }
}







