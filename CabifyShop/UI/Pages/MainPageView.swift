//
//  ContentView.swift
//  CabifyShop
//
//  Created by Demian Odasso on 29/01/2023.
//

import SwiftUI

/// App main page.
struct MainPageView: View {
    var body: some View {
        MainView(
            viewPresentable: MainPagePresentable(cartBadgeValue: 99)
        )
    }
}

/// App main view.
struct MainView: View {
    let viewPresentable: MainPagePresentable
    
    var body: some View {
        TabView {
            ProductsView(
                products: [ProductItemPresentable(code: "T-SHIRT",
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
                                                  price: "$5.00")
                ],
                onRefresh: {},
                onAddToCart: { _ in }
            )
            .tabItem {
                Label("Products", systemImage: "list.star")
            }
            Text("Cart")
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
                .badge(viewPresentable.cartBadgeValue)
        }
        .accentColor(.indigo)
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(
            viewPresentable: MainPagePresentable(cartBadgeValue: 99)
        )
    }
}
