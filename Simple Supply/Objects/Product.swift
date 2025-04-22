//
//  Product.swift
//  Simple Supply
//
//  Created by Will Gibson on 11/30/24.
//

import SwiftData
import SwiftUI

/// Product Object
///
/// Has a name (String), a list of materials used (``ProductMaterial``), and a randomly assigned color.
@Model
class Product {
    var name: String
    var materialsUsed: [ProductMaterial]
    /// Randomly assigned color.
    ///
    /// >Warning: Currently, this color will change every time the app closes and re-opens. I am working to fix this. See Issue #4 in GitHub for more
    var color: Color { return Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1)) }

    init(name: String, materialsUsed: [ProductMaterial]) {
        self.name = name
        self.materialsUsed = materialsUsed
    }
}
