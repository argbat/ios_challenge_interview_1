//
//  MainPagePresentable.swift
//  CabifyShop
//
//  Created by Demian Odasso on 30/01/2023.
//

/// Holds representable data for main page view.
struct MainPagePresentable {
    let cartBadgeValue: Int
    
    func copyWith(
        cartBadgeValue: Int? = nil
    ) -> MainPagePresentable {
        return MainPagePresentable(
            cartBadgeValue: cartBadgeValue == nil ? self.cartBadgeValue : cartBadgeValue!
        )
    }
}
