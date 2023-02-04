//
//  PromotionStrategy.swift
//  CabifyShop
//
//  Created by Demian Odasso on 02/02/2023.
//

import Foundation

protocol PromotionStrategy {
    /// - Returns the new total price to charge
    func apply(price: Decimal, quantity: UInt) -> Decimal
}

/// Use a no promotion strategy when there is no promotion for an item.
final class NoPromotionStrategy: PromotionStrategy {
    /// - Returns no changes on the regular total price (price x quantity)
    func apply(price: Decimal, quantity: UInt) -> Decimal {
        return price * Decimal(quantity)
    }
}

final class TwoForOnePromotionStrategy: PromotionStrategy {
    func apply(price: Decimal, quantity: UInt) -> Decimal {
        let quotient = Decimal(quantity / 2)
        let module = Decimal(quantity % 2)
        return price * (quotient + module)
    }
}

final class DiscountForQuantityPromotionStrategy: PromotionStrategy {
    private let activationQuantity: Decimal
    private let promotedPrice: Decimal
    
    init(activationQuantity: UInt, promotedPrice: Decimal) {
        self.activationQuantity = Decimal(activationQuantity)
        self.promotedPrice = promotedPrice
    }
    
    func apply(price: Decimal, quantity: UInt) -> Decimal {
        let quantity = Decimal(quantity)
        if quantity < activationQuantity {
            return price * quantity
        }
        return promotedPrice * quantity
    }
}
