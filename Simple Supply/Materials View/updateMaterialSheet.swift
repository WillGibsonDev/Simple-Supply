//
//  updateMaterialSheet.swift
//  AHE Inventory App
//
//  Created by Will Gibson on 12/1/24.
//

import SwiftUI

struct updateMaterialSheet: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Bindable var material: Material
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    TextField("Material Name", text: $material.name)
                    TextField("Quantity", value: $material.quantity, format: .number)
                }
                Spacer()
                Button("Delete Item") {
                    context.delete(material)
                    
                    do {
                        try context.save()
                    } catch {
                        print("Can't save after delete")
                    }
                    
                    dismiss()
                    
                }
                    .tint(.red)
                    .fontWeight(.semibold)
                    .padding(.bottom, 30)
            }
            .navigationTitle("Update Material")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}
