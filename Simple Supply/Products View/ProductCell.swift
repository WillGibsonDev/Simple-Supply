//
//  ProductCell.swift
//  Simple Supply
//
//  Created by Will Gibson on 11/30/24.
//

import SwiftUI

/// Individual product cells
///
/// These cells have a ``Product`` object associated with them. Creates a rounded rectangle using the products associated color and name.
///
/// Future work includes updating the program to use product images rather than color. This will require vastly refactoring this view.
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
