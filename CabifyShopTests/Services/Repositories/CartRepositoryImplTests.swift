//
//  CartRepositoryImplTests.swift
//  CabifyShopTests
//
//  Created by Demian Odasso on 03/02/2023.
//

import XCTest
import Combine

@testable import CabifyShop

final class CartRepositoryImplTests: XCTestCase {
    func test_load_empty() {
        let sut = CartRepositoryImpl()
        
        XCTAssertTrue(sut.load().isEmpty)
    }

    func test_load_notEmpty() {
        let sut = CartRepositoryImpl()
        
        sut.save(updatedCart: [product1])
        
        XCTAssertFalse(sut.load().isEmpty)
    }
}
