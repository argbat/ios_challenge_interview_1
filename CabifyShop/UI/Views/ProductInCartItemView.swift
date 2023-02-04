//
//  ProductInCartItemView.swift
//  CabifyShop
//
//  Created by Demian Odasso on 01/02/2023.
//

import SwiftUI

struct ProductInCartItemView: View {
    let product: ProductItemPresentable
    let onRemove: (ProductItemPresentable) -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                ProductNameView(name: product.name)
                ProductPromotionHint(hint: product.promotion)
            }
            Spacer()
            VStack {
                Button(action: { onRemove(product) }) {
                    Text("Remove")
                        .foregroundColor(.red)
                }
                Spacer()
                Text(product.price)
            }
        }
    }
}

struct ProductInCartItemView_Previews: PreviewProvider {
    static var previews: some View {
        ProductInCartItemView(
            product: ProductItemPresentable(
                code: "MUG",
                name: "Cabify Coffee Mug",
                promotion: "3 or more get a discount",
                showPromotion: true,
                price: "$15.00"),
            onRemove: { _ in }
        )
        .previewLayout(.fixed(width: 320, height: 90))
    }
}
