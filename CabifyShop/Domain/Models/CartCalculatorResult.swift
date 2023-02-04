//
//  CartCalculatorResult.swift
//  CabifyShop
//
//  Created by Demian Odasso on 02/02/2023.
//

import Foundation

/// Holds data for a cart checkout.
struct CartCalculatorResult {
    let subtotal: Decimal
    let discounts: Decimal
    let total: Decimal
    var hasDiscounts: Bool {
        discounts > Decimal.zero
    }
    
    static let empty =
        CartCalculatorResult(
            subtotal: Decimal.zero,
            discounts: Decimal.zero,
            total: Decimal.zero
        )
}
