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
            Text("Products")
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
