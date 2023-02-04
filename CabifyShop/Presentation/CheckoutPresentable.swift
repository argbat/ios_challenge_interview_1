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
    
    /// Maps a cart  calculator result to a checkout presentable.
    ///
    ///  - Returns an instance with representable data or nil if mapping fails.
    static func map(result: CartCalculatorResult) -> CheckoutPresentable? {
        let priceFormatter = NumberFormatter()
        
        guard
            let subtotal = priceFormatter.priceFormatter(price: result.subtotal),
            let discounts = priceFormatter.priceFormatter(price: result.discounts),
            let total = priceFormatter.priceFormatter(price: result.total) else {
            return nil
        }

        return CheckoutPresentable(
            subtotal: subtotal,
            showDiscounts: result.hasDiscounts,
            discounts: discounts,
            youWillPay: total)
    }
}
