//
//  MockData.swift
//  AHE Inventory App
//
//  Created by Will Gibson on 10/15/24.
//

import SwiftData

func setupSampleData(modelContext: ModelContext) {
    let wood = Material(name: "Wood", quantity: 50)
    let nails = Material(name: "Nails", quantity: 100)

    modelContext.insert(wood)
    modelContext.insert(nails)
    
    let chair = Product(name: "Chair", materialsUsed: [ProductMaterial(material: wood, requiredQuantity: 5), ProductMaterial(material: nails, requiredQuantity: 12)])
    
    modelContext.insert(chair)

    do {
        try modelContext.save()
        print("Sample data has been set up. Materials saved successfully.")
    } catch {
        print("Failed to save sample data: \(error)")
    }
}


