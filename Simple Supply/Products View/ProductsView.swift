//
//  ContentView.swift
//  Simple Supply
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
    
    @State private var isShowingCantCreateAlert = false
    @State private var isShowingSuccessAlert = false
    
    var body: some View {
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
                            .alert("Not enough materials", isPresented: $isShowingCantCreateAlert){
                                Button("Cancel", role: .cancel) { }
                            } message: {
                                Text("You do not have enough material to create this product.")
                            }
                    }
                    
                }
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





