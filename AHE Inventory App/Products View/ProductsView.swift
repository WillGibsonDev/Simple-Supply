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
    @Binding var addSheetPresented: Bool = projectedValue
    var body: some View {
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
                } header: {
                    Text("Products")
                        .font(.largeTitle.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

            }
            .sheet(isPresented: $addSheetPresented, content: <#T##() -> View#>)
            .padding(20)
        }
        
    }
}




#Preview {
    ProductsView()
}


struct ProductCell: View {
    var product: Product
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(product.color.gradient)
                .frame(height: 250)
            VStack{
                Text(product.name)
                    .font(.title.bold())
            }
            .padding(50)
        }

    }
}
