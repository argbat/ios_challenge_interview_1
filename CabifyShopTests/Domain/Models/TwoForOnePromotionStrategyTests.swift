//
//  TwoForOnePromotionStrategyTests.swift
//  CabifyShopTests
//
//  Created by Demian Odasso on 02/02/2023.
//

import XCTest
import Combine

@testable import CabifyShop

final class TwoForOnePromotionStrategyTests: XCTestCase {
    func test_apply_oneProduct_paysAsOneItem() {
        let sut = TwoForOnePromotionStrategy()
        
        let newPrice = sut.apply(
            price: Decimal(10),
            quantity: 1
        )
        
        XCTAssertEqual(newPrice, Decimal(10.0))
    }
    
    func test_apply_twoEqualProducts_paysAsOneItem() {
        let sut = TwoForOnePromotionStrategy()
        
        let newPrice = sut.apply(
            price: Decimal(10),
            quantity: 2
        )
        
        XCTAssertEqual(newPrice, Decimal(10.0))
    }
    
    func test_apply_threeEqualProducts_paysAsTwoItems() {
        let sut = TwoForOnePromotionStrategy()
        
        let newPrice = sut.apply(
            price: Decimal(10.0),
            quantity: 3
        )
        
        XCTAssertEqual(newPrice, Decimal(20.0))
    }
    
    func test_apply_fourEqualProducts_paysAsTwoItems() {
        let sut = TwoForOnePromotionStrategy()
        
        let newPrice = sut.apply(
            price: Decimal(10),
            quantity: 4
        )
        
        XCTAssertEqual(newPrice, Decimal(20.0))
    }
}
