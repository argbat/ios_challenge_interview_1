//
//  ProductItemPresentableTests.swift
//  CabifyShopTests
//
//  Created by Demian Odasso on 30/01/2023.
//

import XCTest

@testable import CabifyShop

final class ProductItemPresentableTests: XCTestCase {
    func test_represents_true() throws {
        let sut = ProductItemPresentable.map(
            product: product1,
            promotions: [promotionProduct1Code, promotionProduct2Code]
        )
        
        let unwrappedSut = try XCTUnwrap(sut)
        XCTAssertEqual(unwrappedSut.represents(product: product1), true)
    }
    
    func test_represents_false() throws {
        let sut = ProductItemPresentable.map(
            product: product1,
            promotions: [promotionProduct1Code, promotionProduct2Code]
        )
        
        let unwrappedSut = try XCTUnwrap(sut)
        XCTAssertEqual(unwrappedSut.represents(product: product2), false)
    }
    
    func test_map() throws {
        let sut = ProductItemPresentable.map(
            product: product1,
            promotions: [promotionProduct1Code, promotionProduct2Code]
        )
        
        let unwrappedSut = try XCTUnwrap(sut)
        XCTAssertEqual(unwrappedSut.code, product1.code)
        XCTAssertEqual(unwrappedSut.name, product1.name)
        XCTAssertEqual(unwrappedSut.price, "$1.00")
        XCTAssertEqual(unwrappedSut.promotion, "Discount")
        XCTAssertEqual(unwrappedSut.showPromotion, true)
    }
    
    func test_map_emptyPromotions_doNotShowPromotion() throws {
        let sut = ProductItemPresentable.map(
            product: product1,
            promotions: []
        )
        
        let unwrappedSut = try XCTUnwrap(sut)
        XCTAssertEqual(unwrappedSut.code, product1.code)
        XCTAssertEqual(unwrappedSut.name, product1.name)
        XCTAssertEqual(unwrappedSut.price, "$1.00")
        XCTAssertEqual(unwrappedSut.promotion, "")
        XCTAssertEqual(unwrappedSut.showPromotion, false)
    }
    
    func test_map_productWithNoPromoiton_doNotShowPromotion() throws {
        let sut = ProductItemPresentable.map(
            product: productWithOutPromotion,
            promotions: [promotionProduct1Code, promotionProduct2Code]
        )
        
        let unwrappedSut = try XCTUnwrap(sut)
        XCTAssertEqual(unwrappedSut.code, productWithOutPromotion.code)
        XCTAssertEqual(unwrappedSut.name, productWithOutPromotion.name)
        XCTAssertEqual(unwrappedSut.price, "$20.00")
        XCTAssertEqual(unwrappedSut.promotion, "")
        XCTAssertEqual(unwrappedSut.showPromotion, false)
    }
}
