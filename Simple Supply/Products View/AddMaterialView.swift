//
//  AddMaterialView.swift
//  Simple Supply
//
//  Created by Will Gibson on 11/30/24.
//

import SwiftUI
import SwiftData

/// Sheet view to add a ``Material`` object used by the ``Product``.
struct AddMaterialView: View {
    @Query var availableMaterials: [Material]
    @Binding var selectedMaterial: Material?
    @Binding var selectedQuantity: Int
    
    // This is AddProductSheet.addMaterial()
    var onAdd: () -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Select Material")) {
                    Picker("Material", selection: $selectedMaterial) {
                        ForEach(availableMaterials) { material in
                            Text(material.name).tag(material as Material?)
                        }
                    }
                }
                
                Section(header: Text("Enter Quantity")) {
                    TextField("Quantity", value: $selectedQuantity, format: .number)
                        .keyboardType(.numberPad)
                }
            }
            .navigationTitle("Add Material")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        onAdd()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
