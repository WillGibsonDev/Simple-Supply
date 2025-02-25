//
//  MaterialsView.swift
//  AHE Inventory App
//
//  Created by Will Gibson on 11/30/24.
//


struct MaterialsView: View {
    @Environment(\.modelContext) private var context
    @Query var materials: [Material]
    var body: some View {
        VStack {
            HStack{
                Text("Materials")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(20)
                Spacer()
            }
            List(materials, id: \.self) { material in
                Text("\(material.name): \(material.quantity)")
            }
            
        }
    }
}