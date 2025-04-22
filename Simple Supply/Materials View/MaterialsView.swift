//
//  MaterialsView.swift
//  Simple Supply
//
//  Created by Will Gibson on 11/30/24.
//

import SwiftUI
import SwiftData

/// View to show all materials
///
/// Utilizes a list to display materials. A plus button up in the toolbar adds new materials to the list.
///
/// When a list element is tapped, it pops up an editing page where attributes can be modified.
///
/// ``` Swift
///List(materials, id: \.self) { material in
///     Text("\(material.name): \(material.quantity)")
///         .onTapGesture { materialToEdit = material }
///}
///```
///
/// See also ``Material``
///
struct MaterialsView: View {
    // Default Model Context
    @Environment(\.modelContext) private var context
    // List of all materials stored in the context
    @Query var materials: [Material]
    
    // Show/hide sheet view to create new material
    @State private var addSheetPresented: Bool = false
    
    // Determine which item to edit
    @State private var materialToEdit: Material?
    
    // Low Material Alert (WIP)
//    @State private var isShowingLowMaterialAlert = false
    
    var body: some View {
        
        // Utilizes a list for materials.
        // Displays Product: Quantity (Ex. Wood: 7)
        NavigationStack {
            
            List(materials, id: \.self) { material in
                Text("\(material.name): \(material.quantity)")
                    .onTapGesture {
                        materialToEdit = material
                    }
            }
            // Show/hide add sheet
            .sheet(isPresented: $addSheetPresented, content: {
                AddMaterialSheet()
            })
            // Show/hide edit sheet
            .sheet(item: $materialToEdit, content: { material in
                updateMaterialSheet(material: material)
            })
            .navigationTitle("Materials")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { addSheetPresented = true} ) {
                        Label("", systemImage: "plus")
                    }
                }
            }
            // Content Unavailable View (no materials)
            .overlay {
                if materials.isEmpty {
                    ContentUnavailableView(label: {
                        Label("No Materials", systemImage: "list.bullet.rectangle.portrait")
                    }, description: {
                        Text("Start adding materials to see your list.")
                    }, actions:  {
                        Button("Add Material") { addSheetPresented = true }
                    })
                    .offset(y: -60)
                }
            }
        }
        .padding(20)
    }
}



#Preview {
    MaterialsView()
}
