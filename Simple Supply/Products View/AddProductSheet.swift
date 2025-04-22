//
//  AddProductSheet.swift
//  Simple Supply
//
//  Created by Will Gibson on 11/30/24.
//

import SwiftUI
import SwiftData
import Combine

/// Sheet view for creating a new ``Product`` object
///
/// Utlizes an additional sheet, ``AddMaterialView``, to create a list of ``Material`` objects used by this Product.
///
/// The list of Materials needed is formatted similarly to ``MaterialsView``, with a lsit of Material and Quantity
struct AddProductSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    
    // All attributes available to edit
    @State private var name: String = ""
    @State private var materialsUsed: [ProductMaterial] = []
    
    // State variable for adding a new required material for creating this product.
    @State private var isAddingMaterial = false
    @State private var selectedMaterial: Material?
    @State private var selectedQuantity: Int = 1
    
    
    var body: some View {
        NavigationStack {
            Form {
                // Section to update the product name
                Section(header: Text("Product Details")) {
                    TextField("Product Name", text: $name)
                }
                
                // Section to update a list of materials used to create the product, along with their quantity.
                // This functions the same way as the MaterialsView
                Section(header: Text("Materials Used")) {
                    if materialsUsed.isEmpty {
                        Text("No materials added yet")
                            .foregroundStyle(Color.gray)
                    } else {
                        ForEach($materialsUsed) { material in
                            HStack {
                                Text(material.material.name.wrappedValue)
                                Spacer()
                                Text("\(material.requiredQuantity.wrappedValue)")
                            }
                        }
                        .onDelete(perform: deleteMaterial)
                    }
                    Button(action: { isAddingMaterial = true }) {
                        Label("Add Material", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddingMaterial) {
                AddMaterialView(
                    selectedMaterial: $selectedMaterial,
                    selectedQuantity: $selectedQuantity,
                    onAdd: addMaterial)
            }
            .navigationTitle("Add Product")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save"){
                        saveProduct()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel"){
                        dismiss()
                    }
                }
            }
        }
    }
    
    
    /// Function passed to ``AddMaterialView`` to handle adding a ``Material`` object used by the ``Product``
    private func addMaterial() {
        if let material = selectedMaterial {
            let productMaterial = ProductMaterial(material: material, requiredQuantity: selectedQuantity)
            materialsUsed.append(productMaterial)
            isAddingMaterial = false
        }
    }
    
    
    /// Function to delete a ``Material`` from the list of used materials.
    /// - Parameter offsets: Describes which item in the list to delete.
    ///
    /// This is used internally by the ".onDelete" method.
    private func deleteMaterial(at offsets: IndexSet) {
        materialsUsed.remove(atOffsets: offsets)
    }
    
    
    /// Save Method.
    private func saveProduct() {
        let product = Product(name: name, materialsUsed: materialsUsed)
        context.insert(product)
        
        do {
            try context.save()
        } catch {
            //TODO: Replace all print statements with alerts on UI
            print("Error saving")
        }
        dismiss()
    }
}



#Preview {
    AddProductSheet()
}
