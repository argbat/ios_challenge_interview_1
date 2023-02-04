//
//  ProductItemView.swift
//  CabifyShop
//
//  Created by Demian Odasso on 30/01/2023.
//

import SwiftUI

// Use this view to display an item.
struct ProductItemView: View {
    let product: ProductItemPresentable
    let onAddToCart: (ProductItemPresentable) -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                ProductNameView(name: product.name)
                if product.showPromotion {
                    ProductPromotionHint(
                        hint: product.promotion
                    )
                }
                Spacer().frame(height: 8)
                HStack {
                    ProductPriceView(
                        price: product.price
                    )
                    Spacer()
                    CabifyButton(
                        text: "Add To Cart",
                        action: { onAddToCart(product) }
                    )
                }
            }.padding()
        }
        .modifier(AsCard())
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductItemView(
            product: ProductItemPresentable(
                code: "T-SHIRT",
                name: "Cabify T-Shirt",
                promotion: "2For1 on this item and more",
                showPromotion: true,
                price: "$20.00"),
            onAddToCart: { _ in }
        )
        .previewLayout(.fixed(width: 320, height: 220))
        
        ProductItemView(
            product: ProductItemPresentable(
                code: "LONG",
                name: "This is a long product name for this product",
                promotion: "This a long promotion description for this product but not for others",
                showPromotion: true,
                price: "$999999.99"),
            onAddToCart: { _ in }
        )
        .previewLayout(.fixed(width: 320, height: 220))
    }
}
