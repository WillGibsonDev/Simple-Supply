//
//  funcation.swift
//  Simple Supply
//
//  Created by Will Gibson on 11/30/24.
//


/// A function to check material quantities and deduct necessary amounts.
/// - Parameters:
///   - name: Name of the ``Product`` being created
///   - materialsNeeded: List of ``Material`` necessary  for creating this product, in the form of ``ProductMaterial`` objects.
///   - availableMaterials: List of all ``Material`` objects stored in SwiftData
/// - Returns: An optional ``Product`` object. A return of "nil" indicates that a product could not be made. A return of a Product indicates a success.
///
///>Note: This function does not create Alert objects seen on the UI. Those are created based on the return of this function. See ``ProductsView`` for Alert declarations. 
///
/// >Warning: A refactor of this funciton will be coming soon, following implementation of error types. This will better indicate what failed and where, as well as communicating this failure to the user more clearly.
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
