//
//  ProductMaterial.swift
//  AHE Inventory App
//
//  Created by Will Gibson on 11/30/24.
//

import SwiftUI
import SwiftData

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
