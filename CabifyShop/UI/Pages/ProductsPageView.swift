//
//  ProductsPageView.swift
//  CabifyShop
//
//  Created by Demian Odasso on 03/02/2023.
//

//
//  ProductsListPageView.swift
//  CabifyShop
//
//  Created by Demian Odasso on 29/01/2023.
//

import SwiftUI

/// Use this view to display a list of products page.
struct ProductsPageView: View {
    var body: some View {
        ProductsView(
            products: [],
            onRefresh: {},
            onAddToCart: { _ in  }
        )
    }
}

/// Use this view to display a list of products.
struct ProductsView: View {
    let products: [ProductItemPresentable]
    let onRefresh: () -> Void
    let onAddToCart: (ProductItemPresentable) -> Void
    
    var body: some View {
        VStack {
            HStack {
                Text("Products")
                    .font(.system(size: 26))
                Spacer()
            }.padding()
            Divider()
            List(products, id: \.id) { product in
                ProductItemView(
                    product: product,
                    onAddToCart: onAddToCart
                )
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .refreshable {
                onRefresh()
            }
        }
    }
}

struct ProductsListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView(
            products: [
                ProductItemPresentable(code: "T-SHIRT",
                                       name: "Cabify T-Shirt",
                                       promotion: "2For1 on this item",
                                       showPromotion: true,
                                       price: "$20.00"),
                ProductItemPresentable(code: "MUG",
                                       name: "Cabify Coffee Mug",
                                       promotion: "3 or more get a discount",
                                       showPromotion: true,
                                       price: "$15.00"),
                ProductItemPresentable(code: "VOUCHER",
                                       name: "Cabify Voucher",
                                       promotion: "",
                                       showPromotion: false,
                                       price: "$5.00"),
            ],
            onRefresh: {},
            onAddToCart: { _ in }
        )
    }
}

