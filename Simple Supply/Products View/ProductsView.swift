//
//  ContentView.swift
//  Simple Supply
//
//  Created by Will Gibson on 9/4/24.
//

import SwiftUI
import SwiftData


/// View to show all products
///
/// Uses a rounded rectangle cell, see ``ProductCell``, to display individual products.
///
/// When a cell is tapped, it runs  ``produceProduct(name:materialsNeeded:availableMaterials:)``.
///
/// See also ``Product``
///
struct ProductsView: View {
    @Environment(\.modelContext) private var context
    // Query for all products and all materials, as materials are necessary to create new product objects and new
    @Query var products: [Product]
    @Query var materials: [Material]
    let columns = [GridItem(.adaptive(minimum: 250), spacing: 20)]
    
    @State private var productToProduce: Product?
    @State private var addSheetPresented: Bool = false
    
    // State variables for showing alerts conditionally
    @State private var isShowingCantCreateAlert = false
    @State private var isShowingSuccessAlert = false
    
    var body: some View {
        // Scroll view used in case there is a large number of products
        NavigationStack{
            ScrollView{
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(products){ product in
                        ProductCell(product: product)
                            .onTapGesture {
                                productToProduce = product
                                let alerts = produceProduct(name: productToProduce!.name, materialsNeeded: productToProduce!.materialsUsed, availableMaterials: materials)
                                
                                if alerts == nil {
                                    isShowingCantCreateAlert = true
                                } else {
                                    isShowingSuccessAlert = true
                                }
                                
                            }
                            // failure alert
                            .alert("Not enough materials", isPresented: $isShowingCantCreateAlert){
                                Button("Cancel", role: .cancel) { }
                            } message: {
                                Text("You do not have enough material to create this product.")
                            }
                    }
                    
                }
                // success alert
                .alert("Success", isPresented: $isShowingSuccessAlert) {
                    Button("Close", role: .cancel) { }
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





