//
//  Material.swift
//  Simple Supply
//
//  Created by Will Gibson on 10/14/24.
//

import SwiftData
import SwiftUI

// Define the Material class as a SwiftData model


/// Material Object.
///
/// Has a name (String) and quantity (Int).
///
/// Using the @Model macro, this is a SwiftData object
@Model
class Material{
    /// Name attribute. Must be unique for every ``Material`` object.
    @Attribute(.unique) var name: String
    var quantity: Int
    
    init(name: String, quantity: Int) {
        self.name = name
        self.quantity = quantity
    }
    
    
    /// Function to deduct some amount of it's associated ``Material``
    /// - Parameter amount: The amount of the Material to deduct
    /// - Returns: True if it was able to deduct the amount, False if it was not
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







