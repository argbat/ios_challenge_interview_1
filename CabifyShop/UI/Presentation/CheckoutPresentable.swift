//
//  CheckoutPresentable.swift
//  CabifyShop
//
//  Created by Demian Odasso on 01/02/2023.
//

import Foundation

/// Holds representable data that summarize a checkout.
struct CheckoutPresentable {
    let subtotal: String
    let showDiscounts: Bool
    let discounts: String
    let youWillPay: String
    
    static let empty = CheckoutPresentable(
        subtotal: "",
        showDiscounts: false,
        discounts: "",
        youWillPay: ""
    )
}
