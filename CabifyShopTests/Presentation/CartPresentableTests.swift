//
//  CartPresentableTests.swift
//  CabifyShopTests
//
//  Created by Demian Odasso on 03/02/2023.
//

import XCTest

@testable import CabifyShop

final class CartPresentableTests: XCTestCase {
    func test_empty() throws {
        let sut = CartPresentable.empty
        
        XCTAssertEqual(sut.products.isEmpty, true)
        XCTAssertEqual(sut.showIsEmpty, true)
    }
    
    func test_map_showIsEmpty_false() throws {
        let sut = CartPresentable.map(
            products: [product1],
            promotions: [promotionProduct1Code]
        )
        
        let unwrappedSut = try XCTUnwrap(sut)
        XCTAssertEqual(unwrappedSut.showIsEmpty, false)
    }
    
    func test_map_products_notEmtpy() throws {
        let sut = CartPresentable.map(
            products: [product1],
            promotions: [promotionProduct1Code]
        )
        
        let unwrappedSut = try XCTUnwrap(sut)
        XCTAssertEqual(unwrappedSut.products.isEmpty, false)
    }
}
