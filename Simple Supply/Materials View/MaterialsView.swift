//
//  MaterialsView.swift
//  AHE Inventory App
//
//  Created by Will Gibson on 11/30/24.
//

import SwiftUI
import SwiftData

struct MaterialsView: View {
    @Environment(\.modelContext) private var context
    @Query var materials: [Material]
    
    @State private var addSheetPresented: Bool = false
    //    @State private var searchTerm = ""
    @State private var materialToEdit: Material?
    
    var body: some View {
        NavigationStack {
            
            List(materials, id: \.self) { material in
                Text("\(material.name): \(material.quantity)")
                    .onTapGesture {
                        materialToEdit = material
                    }
            }
            .sheet(isPresented: $addSheetPresented, content: {
                AddMaterialSheet()
            })
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
