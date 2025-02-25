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

@Model
class Product {
    var name: String // Unique attribute for identification
    var materialsUsed: [ProductMaterial]
    var color: Color { return Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1)) }

    init(name: String, materialsUsed: [ProductMaterial]) {
        self.name = name
        self.materialsUsed = materialsUsed
    }
}

// Define a helper model for Material usage in Products
@Model
class ProductMaterial {
    var material: Material
    var requiredQuantity: Int

    init(material: Material, requiredQuantity: Int) {
        self.material = material
        self.requiredQuantity = requiredQuantity
    }
}


func produceProduct(name: String, materialsNeeded: [ProductMaterial], availableMaterials: [Material]) -> Product? {
    var usedMaterials: [ProductMaterial] = []
    
    // Check if all materials are available in required quantity
    for materialNeeded in materialsNeeded {
        if let matchingMaterial = availableMaterials.first(where: { $0.name == materialNeeded.material.name }) {
            if matchingMaterial.quantity >= materialNeeded.requiredQuantity {
                usedMaterials.append(ProductMaterial(material: matchingMaterial, requiredQuantity: materialNeeded.requiredQuantity))
            } else {
                print("Insufficient \(materialNeeded.material.name). Needed: \(materialNeeded.requiredQuantity), Available: \(matchingMaterial.quantity)")
                return nil // Cannot produce product due to insufficient materials
            }
        } else {
            print("Material \(materialNeeded.material.name) not found.")
            return nil // Cannot produce product due to missing materials
        }
    }
    
    // Deduct material quantities
    for usedMaterial in usedMaterials {
        if let matchingMaterial = availableMaterials.first(where: { $0.name == usedMaterial.material.name }) {
            if matchingMaterial.use(amount: usedMaterial.requiredQuantity) {
                print("\(matchingMaterial.name) used") // Save updated material back into memory
            }
        }
    }
    
    // Create and return the product
    let product = Product(name: name, materialsUsed: usedMaterials)
    print("Product \(name) produced successfully.")
    return product
}
