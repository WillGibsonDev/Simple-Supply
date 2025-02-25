//
//  funcation.swift
//  AHE Inventory App
//
//  Created by Will Gibson on 11/30/24.
//


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