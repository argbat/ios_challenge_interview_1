//
//  CartTotalCalculator.swift
//  CabifyShop
//
//  Created by Demian Odasso on 02/02/2023.
//

import Foundation

/// Calculates a new total price giving items and promotions .
struct CartTotalCalculator {
    enum CartTotalCalculatorErrors: Error, Equatable {
        case NoPromotionForProduct
    }

    let strategyBuilder: (Promotion.Code) -> PromotionStrategy
    
    /// Gets the total new price
    ///
    /// - Returns: new total price.
    func execute(calculatorItems: [Product: UInt], productsPromotion: [Product: Promotion]) throws ->  Decimal {
        try calculatorItems.reduce(Decimal.zero) { partialResult, calculatorItem in
            let (product, quantity) = calculatorItem
            guard let promotion = productsPromotion[product] else {
                throw CartTotalCalculatorErrors.NoPromotionForProduct
            }
            let strategy = strategyBuilder(promotion.code)
            return partialResult + strategy.apply(price: product.price, quantity: quantity)
        }
    }
}
