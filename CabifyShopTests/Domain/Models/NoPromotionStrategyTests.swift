//
//  NoPromotionStrategyTests.swift
//  CabifyShopTests
//
//  Created by Demian Odasso on 02/02/2023.
//

import XCTest
import Combine

@testable import CabifyShop

final class NoPromotionStrategyTests: XCTestCase {
    func test_apply_oneProduct_noChangesOnPriceToPay() {
        let sut = NoPromotionStrategy()
        
        let newPrice = sut.apply(
            price: Decimal(20),
            quantity: 1
        )
        
        XCTAssertEqual(newPrice, Decimal(20.0))
    }
    
    func test_apply_moreThanOneProduct_noChangesOnPriceToPay() {
        let sut = NoPromotionStrategy()
        
        let newPrice = sut.apply(
            price: Decimal(20),
            quantity: 2
        )
        
        XCTAssertEqual(newPrice, Decimal(40.0))
    }
}
