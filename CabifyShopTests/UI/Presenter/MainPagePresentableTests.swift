//
//  MainPagePresentableTests.swift
//  CabifyShopTests
//
//  Created by Demian Odasso on 30/01/2023.
//

import XCTest

@testable import CabifyShop

final class MainPagePresentableTests: XCTestCase {
    func test_copyWith_noChanges_getsCopyWithSameValues() throws {
        let sut = MainPagePresentable(cartBadgeValue: 0)
        
        let updated = sut.copyWith()
        
        XCTAssertEqual(updated.cartBadgeValue, 0)
    }
    
    func test_copyWith_changeBadgeValue_getsCopyWithChangeValue() throws {
        let sut = MainPagePresentable(cartBadgeValue: 0)
        
        let updated = sut.copyWith(cartBadgeValue: 1)
        
        XCTAssertEqual(updated.cartBadgeValue, 1)
    }
}
