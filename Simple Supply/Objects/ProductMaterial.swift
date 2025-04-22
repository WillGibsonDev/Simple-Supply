//
//  ProductMaterial.swift
//  Simple Supply
//
//  Created by Will Gibson on 11/30/24.
//

import SwiftUI
import SwiftData


/// A helper class to combine a ``Material`` with a specific ``requiredQuantity``
///
/// This is used when creating ``Product`` objects, to denote how much of any given Material is used to create said Product
@Model
class ProductMaterial {
    var material: Material
    var requiredQuantity: Int

    init(material: Material, requiredQuantity: Int) {
        self.material = material
        self.requiredQuantity = requiredQuantity
    }
}
