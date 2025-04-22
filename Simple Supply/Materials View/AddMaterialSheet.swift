//
//  AddMaterialSheet.swift
//  Simple Supply
//
//  Created by Will Gibson on 11/30/24.
//

import SwiftUI
import SwiftData

/// Sheet view used to create a new ``Material`` object
struct AddMaterialSheet: View {
    // Default model context
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    // List of all materials stored in the context
    @Query var currentMaterials: [Material]
    
    @State private var name: String = ""
    // Units variable (WIP)
//    @State private var units: String = ""
    @State private var quantity: Int = 0
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Material Name", text: $name)
                    .onSubmit {
                        if currentMaterials.contains(where: { $0.name.lowercased() == name.lowercased() }) {
                            //TODO: Print statements need replaced with Alerts on UI
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
            //TODO: Update all print statements to alerts on UI
            print("Error Saving")
        }
        dismiss()
    }
}

#Preview {
    AddMaterialSheet()
}
