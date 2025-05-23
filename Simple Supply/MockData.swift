//
//  MockData.swift
//  Simple Supply
//
//  Created by Will Gibson on 10/15/24.
//

import SwiftData

// Mock data used in testing. Currently not applied to any distribution of the app.

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


