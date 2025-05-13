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
    
    // Store the color as a hex string (e.g., "#FFAA33")
    private var colorHex: String

    // Computed property to convert hex string to Color
    var color: Color {
        get {
            Color(hex: colorHex) ?? .gray // fallback color
        }
        set {
            colorHex = newValue.toHex() ?? "#808080" // fallback to gray
        }
    }

    init(name: String, materialsUsed: [ProductMaterial]) {
        self.name = name
        self.materialsUsed = materialsUsed
        self.colorHex = Color.randomColor().toHex() ?? "#808080"
    }
}





extension Color {
    static func randomColor() -> Color {
        return Color(red: .random(in: 0...1),
                     green: .random(in: 0...1),
                     blue: .random(in: 0...1))
    }

    // Convert Color to Hex string
    func toHex() -> String? {
        #if canImport(UIKit)
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        guard uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
        return String(format: "#%02lX%02lX%02lX",
                      lroundf(Float(red * 255)),
                      lroundf(Float(green * 255)),
                      lroundf(Float(blue * 255)))
        #else
        return nil
        #endif
    }

    // Initialize Color from hex string
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexSanitized.hasPrefix("#") {
            hexSanitized.removeFirst()
        }

        guard hexSanitized.count == 6,
              let rgbValue = UInt64(hexSanitized, radix: 16) else {
            return nil
        }

        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}
