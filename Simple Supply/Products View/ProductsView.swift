//
//  ContentView.swift
//  AHE Inventory App
//
//  Created by Will Gibson on 9/4/24.
//

import SwiftUI
import SwiftData


struct ProductsView: View {
    @Environment(\.modelContext) private var context
    let columns = [GridItem(.adaptive(minimum: 250), spacing: 20)]
    @Query var products: [Product]
    @Query var materials: [Material]
    
    @State private var productToProduce: Product?
    @State private var addSheetPresented: Bool = false
    
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVGrid(columns: columns, spacing: 20) {
                    Section{
                        ForEach(products){ product in
                            ProductCell(product: product)
                                .onTapGesture {
                                    productToProduce = product
                                    produceProduct(name: productToProduce!.name, materialsNeeded: productToProduce!.materialsUsed, availableMaterials: materials)
                                }
                        }
                    } /*header: {
                        Text("Products")
                            .font(.largeTitle.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }*/
                    
                }

            }
            .padding(.top, 30)
            .sheet(isPresented: $addSheetPresented, content: {
                AddProductSheet()
            })
            .navigationTitle("Products")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { addSheetPresented = true } ) {
                        Label("", systemImage: "plus")
                    }
                }
            }
            .overlay{
                if products.isEmpty {
                    ContentUnavailableView(label: {
                        Label("No Products", systemImage: "list.bullet.rectangle.portrait")
                    }, description: {
                        Text("Start adding products to see your list.")
                    }, actions:  {
                        Button("Add Product") { addSheetPresented = true }
                    })
                    .offset(y: -60)
                }
            }
        }
        .padding(20)
        
    }
}


#Preview {
    ProductsView()
}





