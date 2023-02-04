//
//  ContentView.swift
//  CabifyShop
//
//  Created by Demian Odasso on 30/01/2023.
//

import SwiftUI

/// App main page.
struct MainPageView: View {
    let productsPresenter: ProductsPagePresenter
    let cartPresenter: CartPagePresenter
    
    var body: some View {
        MainView(
            viewPresentable: MainPagePresentable(cartBadgeValue: 99),
            productsPresenter: productsPresenter,
            cartPresenter: cartPresenter
        )
    }
}

/// App main view.
struct MainView: View {
    let viewPresentable: MainPagePresentable
    let productsPresenter: ProductsPagePresenter
    let cartPresenter: CartPagePresenter
    
    var body: some View {
        TabView {
            ProductsPageView(presenter: productsPresenter)
                .tabItem {
                    Label("Products", systemImage: "list.star")
                }
            CartPageView(cartPresenter: cartPresenter)
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
        let composer = Composer()
        MainView(
            viewPresentable: MainPagePresentable(cartBadgeValue: 99),
            productsPresenter: composer.makeProductsPagePresenter(),
            cartPresenter: composer.makeCartPagePresenter()
        )
    }
}
