//
//  CheckoutPresentableTests.swift
//  CabifyShopTests
//
//  Created by Demian Odasso on 03/02/2023.
//

import XCTest

@testable import CabifyShop

final class CheckoutPresentableTests: XCTestCase {
    func test_empty() throws {
        let sut = CheckoutPresentable.empty
        
        XCTAssertEqual(sut.subtotal, "")
        XCTAssertEqual(sut.showDiscounts, false)
        XCTAssertEqual(sut.discounts, "")
        XCTAssertEqual(sut.youWillPay, "")
    }
}
