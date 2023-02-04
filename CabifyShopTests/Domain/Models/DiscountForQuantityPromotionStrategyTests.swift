//
//  DiscountForQuantityPromotionStrategyTests.swift
//  CabifyShopTests
//
//  Created by Demian Odasso on 02/02/2023.
//

import XCTest
import Combine

@testable import CabifyShop

final class DiscountForQuantityPromotionStrategyTests: XCTestCase {
    func test_apply_notActivationQuantity_getsNotPromotedPriceToPay() {
        let sut = DiscountForQuantityPromotionStrategy(
            activationQuantity: 3, promotedPrice: Decimal(19))
        
        var newPrice = sut.apply(
            price: Decimal(20),
            quantity: 1
        )
        XCTAssertEqual(newPrice, Decimal(20.0))
        
        newPrice = sut.apply(
            price: Decimal(20),
            quantity: 2
        )
        XCTAssertEqual(newPrice, Decimal(40.0))
    }
    
    func test_apply_activationQuantity_getsPromotedPriceToPay() {
        let sut = DiscountForQuantityPromotionStrategy(
            activationQuantity: 3, promotedPrice: Decimal(19))
        
        var newPrice = sut.apply(
            price: Decimal(20),
            quantity: 3
        )
        XCTAssertEqual(newPrice, Decimal(19.0) * Decimal(3.0))
        
        newPrice = sut.apply(
            price: Decimal(20),
            quantity: 4
        )
        XCTAssertEqual(newPrice, Decimal(19.0) * Decimal(4.0))
    }
}
