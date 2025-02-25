//
//  AddProductSheet.swift
//  AHE Inventory App
//
//  Created by Will Gibson on 11/30/24.
//

import SwiftUI
import SwiftData
import Combine

struct AddProductSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    
    
    @State private var name: String = ""
    @State private var materialsUsed: [ProductMaterial] = []
    @State private var isAddingMaterial = false
    @State private var selectedMaterial: Material?
    @State private var selectedQuantity: Int = 1
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Product Details")) {
                    TextField("Product Name", text: $name)
                }
                
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
    
    private func addMaterial() {
        if let material = selectedMaterial {
            let productMaterial = ProductMaterial(material: material, requiredQuantity: selectedQuantity)
            materialsUsed.append(productMaterial)
            isAddingMaterial = false
        }
    }
    
    private func deleteMaterial(at offsets: IndexSet) {
        materialsUsed.remove(atOffsets: offsets)
    }
    
    private func saveProduct() {
        let product = Product(name: name, materialsUsed: materialsUsed)
        context.insert(product)
        
        do {
            try context.save()
        } catch {
            print("Error saving")
        }
        // Implement saving logic here
        dismiss()
    }
}



#Preview {
    AddProductSheet()
}
