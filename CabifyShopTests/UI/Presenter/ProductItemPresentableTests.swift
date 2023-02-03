//
//  ProductItemPresentableTests.swift
//  CabifyShopTests
//
//  Created by Demian Odasso on 30/01/2023.
//

import XCTest

@testable import CabifyShop

final class ProductItemPresentableTests: XCTestCase {
    func test_map() throws {
        let sut = ProductItemPresentable.map(product: product1)
        
        let unwrappedSut = try XCTUnwrap(sut)
        XCTAssertEqual(unwrappedSut.code, product1.code)
        XCTAssertEqual(unwrappedSut.name, product1.name)
        XCTAssertEqual(unwrappedSut.price, "$1.00")
        XCTAssertEqual(unwrappedSut.promotion, "")
        XCTAssertEqual(unwrappedSut.showPromotion, false)
    }
}
