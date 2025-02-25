//
//  ProductCell.swift
//  AHE Inventory App
//
//  Created by Will Gibson on 11/30/24.
//

import SwiftUI

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
