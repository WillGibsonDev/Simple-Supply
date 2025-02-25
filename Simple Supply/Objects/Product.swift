//
//  Product.swift
//  AHE Inventory App
//
//  Created by Will Gibson on 11/30/24.
//

import SwiftData
import SwiftUI

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
