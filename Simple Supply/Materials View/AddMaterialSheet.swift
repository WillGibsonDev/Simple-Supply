//
//  AddMaterialSheet.swift
//  AHE Inventory App
//
//  Created by Will Gibson on 11/30/24.
//

import SwiftUI
import SwiftData

struct AddMaterialSheet: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @Query var currentMaterials: [Material]
    
    @State private var name: String = ""
//    @State private var units: String = ""
    @State private var quantity: Int = 0
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Material Name", text: $name)
                    .onSubmit {
                        if currentMaterials.contains { $0.name.lowercased() == name.lowercased() } {
                            print("error, can't submit")
                        }

                    }
                TextField("Quantity", value: $quantity, format: .number)
            }
            .navigationTitle("Add Material")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveMaterial()
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
    
    private func saveMaterial() {
        let material = Material(name: name, quantity: quantity)
        context.insert(material)
        
        do {
            try context.save()
        } catch {
            print("Error Saving")
        }
        dismiss()
    }
}

#Preview {
    AddMaterialSheet()
}
